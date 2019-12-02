#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include "xil_printf.h"
#include "xknearestneighbor.h"
#include "xil_io.h"                 // for reading/writing to individual memory locations
#include "xil_mem.h"                // for memcpy
#include "xparameters.h"            // Parameter definitions for processor peripherals
#include "xscugic.h"                // Processor interrupt controller device driver
#include <inttypes.h>               // To print uintx_t and intx_t types properly using printf
#include "xtime_l.h"                // Used to measure time (ARM cc's) a function
#include "xil_cache.h"
#include "Dataset16.h"

#define KNNBRS 9
#define ROWS ((1<<16)+1)
#define DIM	 16

// To interface with ISR
volatile static int runHlsHw = 0;
volatile static int resultAvailHlsHw = 0;

typedef int32_t data_t;

// Note: to store distance squared,
// 		 we need bit size of atleast 16+16+log2(dimensions)
//		 = 32+3 = 35 bits for 8 dims,
//		 = 32+4 = 36 bits for  16 dimensions
typedef int64_t datasqrd_t;

typedef struct
{
	data_t rowIndex;
	datasqrd_t distSqrd;
}NbrDistSqrdType;

int sortPointsByDistance(const void* obj1, const void *obj2)
{
	int64_t d1 = ((NbrDistSqrdType*)obj1)->distSqrd;
	int64_t d2 = ((NbrDistSqrdType*)obj2)->distSqrd;

	if( d1 < d2 ) 		return -1;
	else if (d1 > d2 )	return +1;
	else				return 0;
}

void ArmSwModel(int volatile const *pSrcBuffer,
				int Nbrs,
                int volatile *pKIndexes
                )
{
	static NbrDistSqrdType NbrsDistSqrdObjs[ROWS-1];

	int	volatile const *pRefDataPoint = &pSrcBuffer[0];
	int volatile const *pSrcDataPoints = &pSrcBuffer[DIM+1];

	for( int32_t r = 0; r < ROWS-1; ++r)
	{
		int64_t tempDiff = 0;
		int64_t tempSqrd = 0;
		int64_t tempSqrdSum = 0;
		for( data_t d = 1 ; d <= DIM; ++d )
		{
			data_t const refCoordinate = pRefDataPoint[d];
			data_t const ptCoordinate = pSrcDataPoints[r*(DIM+1)+d];
			tempDiff = (ptCoordinate - refCoordinate);
			tempSqrd = tempDiff * tempDiff;
			tempSqrdSum += tempSqrd;
		}
		NbrsDistSqrdObjs[r].rowIndex = r;
		NbrsDistSqrdObjs[r].distSqrd = tempSqrdSum;
	}

	qsort(NbrsDistSqrdObjs, ROWS-1, sizeof(NbrDistSqrdType), sortPointsByDistance);

	for( data_t k=0; k < KNNBRS; ++k )
	{
		pKIndexes[k] = 	NbrsDistSqrdObjs[k].rowIndex;
	}
}

// Enable PL to PS interrupt
void enable_interrupt(void *pHlsHwIpInstance)
{
    XKnearestneighbor *pAccelerator = (XKnearestneighbor *)pHlsHwIpInstance;
    XKnearestneighbor_InterruptEnable(pAccelerator,1);
    XKnearestneighbor_InterruptGlobalEnable(pAccelerator);
}

// Define PL to PS ISR
void hls_hw_isr(void *pHlsHwIpInstance)
{
    XKnearestneighbor *pAccelerator = (XKnearestneighbor *)pHlsHwIpInstance;

    //Disable the global interrupt
    XKnearestneighbor_InterruptGlobalDisable(pAccelerator);

    //Disable the local interrupt
    XKnearestneighbor_InterruptDisable(pAccelerator,0xffffffff);

    // clear the local interrupt
    XKnearestneighbor_InterruptClear(pAccelerator,1);
    resultAvailHlsHw = 1;

    // restart the core if it should run again
    if(runHlsHw)
    {
        enable_interrupt(pAccelerator);
        XKnearestneighbor_Start(pAccelerator);
    }
}

// Setup interrupt on ARM PS from FPGA IP instance to ARM PS
int setup_interrupt(XKnearestneighbor *pHlsHwIpInstance, XScuGic* pIntCntrlInstance)
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
                            XPAR_FABRIC_KNEARESTNEIGHBOR_0_INTERRUPT_INTR,
                            (Xil_InterruptHandler)hls_hw_isr,
                            pHlsHwIpInstance);

    if(result != XST_SUCCESS){ return result;}

    // Enable the Interrupt Source
    XScuGic_Enable(pIntCntrlInstance,XPAR_FABRIC_KNEARESTNEIGHBOR_0_INTERRUPT_INTR);

    return XST_SUCCESS;
}

// Initialize HLS IP Instance
int hls_hw_init(XKnearestneighbor *pHlsHwIpInstance)
{
    int status;
    XKnearestneighbor_Config *pCfgHlsHwIp;

    pCfgHlsHwIp  = XKnearestneighbor_LookupConfig( XPAR_XKNEARESTNEIGHBOR_0_DEVICE_ID );

    if ( !pCfgHlsHwIp )
    {
        print("ERROR: Lookup of accelerator configuration failed.\n");
        return XST_FAILURE;
    }

    status = XKnearestneighbor_CfgInitialize(pHlsHwIpInstance, pCfgHlsHwIp);
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

    XKnearestneighbor hlsHwInstance;    // HLS IP instance
    XScuGic intCntrlInstance;   		// Interrupt controller instance
    XTime timeSwBegin = 0;
    XTime timeSwEnd = 0;
    XTime timeSw = 0;
    XTime timeHwBegin = 0;
    XTime timeHwEnd = 0;
    XTime timeHw = 0;

    u32 ddrStartAddress = (u32)XPAR_PS7_DDR_0_S_AXI_BASEADDR + (u32)0x00800000;
    u32 ddrEndAddress = XPAR_PS7_DDR_0_S_AXI_HIGHADDR;

    printf("WRITING %lu bytes to DDR\n", ddrEndAddress-ddrStartAddress);

    for( u32 ddrAddress = ddrStartAddress; ddrAddress <= (ddrEndAddress-sizeof(uint64_t)); ddrAddress+=sizeof(uint64_t))
    {
    	Xil_Out64(ddrAddress, 0);
    }

    // Destination buffers for output data (stored on stack/text/data segment mapped to ddr)
    int volatile kIndexesOutSw[KNNBRS];

    for( int i=0; i<KNNBRS; ++i)
    {
    	kIndexesOutSw[i] = 0;
    }

    // Before starting the IP, make sure buffers in memory is flushed from cache to ddr
    Xil_DCacheFlushRange((INTPTR)&dataset16[0], sizeof(dataset16));

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
    XKnearestneighbor_Set_data16(&hlsHwInstance, (u32)&dataset16[0]);

    // Check if FPGA HW IP instance is ready
    if(!XKnearestneighbor_IsReady(&hlsHwInstance))
    {
        print("FPGA HLS HW IP HW peripheral is not ready! Exiting ...\n");
        status = XST_FAILURE;
    }

    // Enable the interrupt
    enable_interrupt(&hlsHwInstance);

    XTime_GetTime(&timeHwBegin);
    // Start the HW IP instance
    XKnearestneighbor_Start(&hlsHwInstance);

    // Wait for PS ISR to be triggered by IP Instance
    while(!resultAvailHlsHw); // blocked waiting

    // Before reading the data written to DDR by FPGA, invalidate the
    // corresponding locations in cache so that data recently written data
    // in ddr is moved to cache
    //Xil_DCacheInvalidateRange((INTPTR)dataOutHw, sizeof(dataOutHw) );

    XTime_GetTime(&timeHwEnd);
    timeHw = timeHwEnd - timeHwBegin;

    // Reset hw result available flag
    resultAvailHlsHw = 0;

    XTime_GetTime(&timeSwBegin);

    // Call the SW model of HW IP on ARM CPU core
    ArmSwModel(&dataset16[0], KNNBRS, &kIndexesOutSw[0]);

    XTime_GetTime(&timeSwEnd);
    timeSw = timeSwEnd - timeSwBegin;

	printf("SW cc: %llu, HW cc: %llu, SW Time(sec): %e, HW Time(sec): %e\n",
			timeSw,
			timeHw,
			(double)timeSw/(double)COUNTS_PER_SECOND,
			(double)timeHw/(double)COUNTS_PER_SECOND);

#if 0
    printf( "Out data bytes: %lu\n", XKnearestneighbor_Get_knearest_TotalBytes(&hlsHwInstance));
    printf( "Out data depth: %lu\n", XKnearestneighbor_Get_knearest_Depth(&hlsHwInstance));
    printf( "Out data bit width: %lu\n", XKnearestneighbor_Get_knearest_BitWidth(&hlsHwInstance));
    printf( "Out data base address: %lu\n", XKnearestneighbor_Get_knearest_BaseAddress(&hlsHwInstance));
    printf( "Out data high address: %lu\n", XKnearestneighbor_Get_knearest_HighAddress(&hlsHwInstance));
#endif

    int* kIndexesOutHw = (int*)XKnearestneighbor_Get_knearest_BaseAddress(&hlsHwInstance);

    // Compare HW and Sw results
    for( int i=0; i<KNNBRS; i++)
    {
        printf("i: %d, ARM CPU: %d, FPGA HLS: %d\n", i, kIndexesOutSw[i], kIndexesOutHw[i]);
        if( kIndexesOutHw[i] != kIndexesOutSw[i] ) 	status = XST_FAILURE;
        else										status = XST_SUCCESS;
    }

    if( XST_FAILURE == status ) printf("Test Failed!!!\n");
    else                        printf("Test Passed\n");

    cleanup_platform();
    return 0;
}
