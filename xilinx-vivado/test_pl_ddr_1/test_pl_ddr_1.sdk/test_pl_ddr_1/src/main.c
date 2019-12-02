#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include "xil_printf.h"
#include "xhls_func.h"
#include "xil_io.h"                 // for reading/writing to individual memory locations
#include "xil_mem.h"                // for memcpy
#include "xparameters.h"            // Parameter definitions for processor peripherals
#include "xscugic.h"                // Processor interrupt controller device driver
#include <inttypes.h>               // To print uintx_t and intx_t types properly using printf
#include "xtime_l.h"                // Used to measure time (ARM cc's) a function
#include "xil_cache.h"

#define N 16

// To interface with ISR
volatile static int runHlsHw = 0;
volatile static int resultAvailHlsHw = 0;

void ArmSwModel(uint16_t volatile const *pSrcBuffer,
                uint16_t volatile *pDestBuffer
                )
{
    for(int i=0; i < N; ++i)
    {
        pDestBuffer[i] = pSrcBuffer[i]+1;
    }
}

// Enable PL to PS interrupt
void enable_interrupt(void *pHlsHwIpInstance)
{
    XHls_func *pAccelerator = (XHls_func *)pHlsHwIpInstance;
    XHls_func_InterruptEnable(pAccelerator,1);
    XHls_func_InterruptGlobalEnable(pAccelerator);
}

// Define PL to PS ISR
void hls_hw_isr(void *pHlsHwIpInstance)
{
    XHls_func *pAccelerator = (XHls_func *)pHlsHwIpInstance;

    //Disable the global interrupt
    XHls_func_InterruptGlobalDisable(pAccelerator);

    //Disable the local interrupt
    XHls_func_InterruptDisable(pAccelerator,0xffffffff);

    // clear the local interrupt
    XHls_func_InterruptClear(pAccelerator,1);
    resultAvailHlsHw = 1;

    // restart the core if it should run again
    if(runHlsHw)
    {
        enable_interrupt(pAccelerator);
        XHls_func_Start(pAccelerator);
    }
}

// Setup interrupt on ARM PS from FPGA IP instance to ARM PS
int setup_interrupt(XHls_func *pHlsHwIpInstance, XScuGic* pIntCntrlInstance)
{
    if( !pHlsHwIpInstance || !pIntCntrlInstance ){ return XST_FAILURE; }

    int result;
    XScuGic_Config *pCfgGic = XScuGic_LookupConfig(XPAR_SCUGIC_SINGLE_DEVICE_ID);

    if (pCfgGic == NULL)
    {
        print("Interrupt Configuration Lookup Failed\n");
        return XST_FAILURE;
    }

    result = XScuGic_CfgInitialize(pIntCntrlInstance,pCfgGic,pCfgGic->CpuBaseAddress);

    if(result != XST_SUCCESS){  return result; }

    // self-test
    result = XScuGic_SelfTest(pIntCntrlInstance);
    if(result != XST_SUCCESS){ return result; }

    // Initialize the exception handler
    Xil_ExceptionInit();

    // Register the exception handler
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
                                (Xil_ExceptionHandler)XScuGic_InterruptHandler,
                                pIntCntrlInstance);

    //Enable the exception handler
    Xil_ExceptionEnable();

    // Connect the interrupt id of the interrupt source to the interrupt handler
    result = XScuGic_Connect(pIntCntrlInstance,
                            XPAR_FABRIC_HLS_FUNC_0_INTERRUPT_INTR,
                            (Xil_InterruptHandler)hls_hw_isr,
                            pHlsHwIpInstance);

    if(result != XST_SUCCESS){ return result;}

    // Enable the Interrupt Source
    XScuGic_Enable(pIntCntrlInstance,XPAR_FABRIC_HLS_FUNC_0_INTERRUPT_INTR);

    return XST_SUCCESS;
}

// Initialize HLS IP Instance
int hls_hw_init(XHls_func *pHlsHwIpInstance)
{
    int status;
    XHls_func_Config *pCfgHlsHwIp;

    pCfgHlsHwIp  = XHls_func_LookupConfig( XPAR_XHLS_FUNC_0_DEVICE_ID );

    if ( !pCfgHlsHwIp )
    {
        print("ERROR: Lookup of accelerator configuration failed.\n");
        return XST_FAILURE;
    }

    status = XHls_func_CfgInitialize(pHlsHwIpInstance, pCfgHlsHwIp);
    if (status != XST_SUCCESS)
    {
        print("ERROR: Could not initialize accelerator.\n");
        return XST_FAILURE;
    }

    return XST_SUCCESS;
}

int main()
{
    init_platform();

    // Always hope for the best!
    int status = XST_SUCCESS;

    XHls_func hlsHwInstance;    // HLS IP instance
    XScuGic intCntrlInstance;   // Interrupt controller instance

    u32 ddrStartAddress = (u32)XPAR_PS7_DDR_0_S_AXI_BASEADDR + (u32)0x00800000;
    u32 ddrEndAddress = XPAR_PS7_DDR_0_S_AXI_HIGHADDR;

    printf("WRITING %lu bytes to DDR\n", ddrEndAddress-ddrStartAddress);

    for( u32 ddrAddress = ddrStartAddress; ddrAddress <= (ddrEndAddress-sizeof(uint64_t)); ddrAddress+=sizeof(uint64_t))
    {
    	Xil_Out64(ddrAddress, 0);
    }

    // Destination buffers for output data (stored on stack/text/data segment mapped to ddr)
    uint16_t dataOutHw[N];
    uint16_t dataOutSw[N];

    for( int i=0; i<N; ++i)
    {
    	dataOutHw[i] = 0;
    	dataOutSw[i] = 0;
    }

    // Input data (stored on stack/text/data segment mapped to ddr)
    const uint16_t dataIn8X[N] = {14,57,13,26,45,43,12,97,77,55,90,11,62,23,16,89};

    // Before starting the IP, make sure buffers in memory is flushed from cache to ddr
    Xil_DCacheFlushRange((INTPTR)dataIn8X, sizeof(dataIn8X));

    // Initialize HLS Hardware
    status = hls_hw_init(&hlsHwInstance);
    if( status != XST_SUCCESS )
    {
        print("HLS peripheral setup failed\n");
        exit(-1);
    }

    // Setup the interrupt from PL to PS
    status = setup_interrupt(&hlsHwInstance, &intCntrlInstance);
    if( status != XST_SUCCESS )
    {
        print("PS ISR setup failed\n");
        exit(-1);
    }

    // Send address of source and destination memory buffers on DDR
    // as register values through AXI-lite to the FPGA HLS IP
    XHls_func_Set_pSrcBuffer(&hlsHwInstance, (u32)&dataIn8X[0]);
    XHls_func_Set_pDestBuffer(&hlsHwInstance, (u32)&dataOutHw[0]);

    // Check if FPGA HW IP instance is ready
    if(!XHls_func_IsReady(&hlsHwInstance))
    {
        print("FPGA HLS HW IP HW peripheral is not ready! Exiting ...\n");
        status = XST_FAILURE;
    }

    // Enable the interrupt
    enable_interrupt(&hlsHwInstance);

    // Start the HW IP instance
    XHls_func_Start(&hlsHwInstance);

    // Wait for PS ISR to be triggered by IP Instance
    while(!resultAvailHlsHw); // blocked waiting

    // Before reading the data written to DDR by FPGA, invalidate the
    // corresponding locations in cache so that data recently written data
    // in ddr is moved to cache
    //Xil_DCacheInvalidateRange((INTPTR)dataOutHw, sizeof(dataOutHw) );

    // Reset hw result available flag
    resultAvailHlsHw = 0;

    // Call the SW model of HW IP on ARM CPU core
    ArmSwModel(&dataIn8X[0], &dataOutSw[0]);

    // Compare HW and Sw results
    for( int i=0; i<N; i++)
    {
        printf("i: %d, ARM CPU: %d, FPGA HLS: %d\n", i, dataOutSw[i], dataOutHw[i]);
        if( dataOutHw[i] != dataOutSw[i] )
        {
            status = XST_FAILURE;
        }
        else
        {
        	status = XST_SUCCESS;
        }
    }

    printf( "Out data bytes: %lu\n", XHls_func_Get_outData_TotalBytes(&hlsHwInstance));
    printf( "Out data depth: %lu\n", XHls_func_Get_outData_Depth(&hlsHwInstance));
    printf( "Out data bit width: %lu\n", XHls_func_Get_outData_BitWidth(&hlsHwInstance));
    printf( "Out data base address: %lu\n", XHls_func_Get_outData_BaseAddress(&hlsHwInstance));
    printf( "Out data high address: %lu\n", XHls_func_Get_outData_HighAddress(&hlsHwInstance));

    uint16_t* outBeginAdd = (uint16_t*)XHls_func_Get_outData_BaseAddress(&hlsHwInstance);

    // Compare HW and Sw results
    for( int i=0; i<N; i++)
    {
        printf("i: %d, ARM CPU: %d, FPGA HLS: %d\n", i, dataOutSw[i], outBeginAdd[i]);
        if( outBeginAdd[i] != dataOutSw[i] )
        {
            status = XST_FAILURE;
        }
        else
        {
        	status = XST_SUCCESS;
        }
    }

    if( XST_FAILURE == status ) printf("Test Failed!!!\n");
    else                        printf("Test Passed\n");

    cleanup_platform();
    return 0;
}
