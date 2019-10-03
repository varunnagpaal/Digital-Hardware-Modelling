/*
 * ackermann.c: Calculates Ackermann function of two numbers on Zynq FPGA and ARM
 *
 *
 * Name: Nagpal, Varun
 * Date: Oct, 03rd 2019
 *
 * Usage: The code can be run in two modes. User needs to choose run mode from SDK serial console when prompted
 * 	Run Mode 0: Calculates Ackermann function of two numbers X and Y provided by user on SDK serial terminal for both Zynq FPGA and ARM CPU core.
 * 	Run Mode 1: Measures and reports average execution time for calculating Ackermann function on both Zynq FPGA and ARM CPU core.
 *
 *	To run Mode 0, enter 0 when prompted on SDK serial console
 * 	To run Mode 1, enter 1 when prompted on SDK serial console
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"

#include <stdlib.h> // Standard C functions, e.g. exit()
#include <stdbool.h> // Provides a Boolean data type for ANSI/ISO-C
#include "xparameters.h" // Parameter definitions for processor peripherals
#include "xscugic.h" // Processor interrupt controller device driver
#include "xackhls.h" // Device driver for HLS HW block
#include "xil_assert.h"
#include "xtime_l.h"
#include <inttypes.h>

#define N 9

// To interface with ISR
volatile static int runHlsHw = 0;
volatile static int resultAvailHlsHw = 0;

void ackArm(uint8_t x, uint64_t y, uint64_t *pResult)
{
	uint8_t I = x;
	uint64_t xar[N];
    uint64_t sum[N];
	uint64_t result = 0;
	uint64_t i;
	int transfer;

	for (int n = 0;n <= I;n++)
	{
		xar[n] = 0;
		sum[n] = 1;
	}
	sum[I] = -1;
	do
	{
		i = 0;
		result = xar[0] + 1;
		transfer = 1;

		while (transfer)
			{
				if (xar[i] == sum[i])
				{
					sum[i] = result;
				}
				else
				{
					transfer = 0;
				}

				xar[i] += 1;
				i++;
			}
	} while (xar[x] < y + 1);

	*pResult = result;
}

void ackExpected(uint8_t x, uint64_t y, uint64_t *pVal)
{
	switch (x)
	{
	case 0: if (y <= UINT64_MAX - 1) *pVal = y + 1;
			else *pVal = 0;
			break;

	case 1: if (y <= UINT64_MAX - 2) *pVal = y + 2;
			else *pVal = 0;
			break;

	case 2: if (y <= (UINT64_MAX - 3) >> 1) *pVal = 2 * y + 3;
			else *pVal = 0;
			break;

	case 3: if (y <= 61) *pVal = ((uint64_t)1 << (y + 3)) - 3;
			else *pVal = 0;
			break;

	case 4: if (y == 0) *pVal = 13;
			else if (y == 1) *pVal = 65533;
			else *pVal = 0;
			break;

	case 5: if (y == 0) *pVal = 65533;
			else *pVal = 0;
			break;

	default: *pVal = 0;
		break;
	}
}

// Enable PL to PS interrupt
void enable_interrupt(void *pHlsHwIpInstance)
{
	XAckhls *pAccelerator = (XAckhls *)pHlsHwIpInstance;
	XAckhls_InterruptEnable(pAccelerator,1);
	XAckhls_InterruptGlobalEnable(pAccelerator);
}

// Define PL to PS ISR
void hls_hw_isr(void *pHlsHwIpInstance)
{
	XAckhls *pAccelerator = (XAckhls *)pHlsHwIpInstance;

	//Disable the global interrupt
	XAckhls_InterruptGlobalDisable(pAccelerator);

	//Disable the local interrupt
	XAckhls_InterruptDisable(pAccelerator,0xffffffff);

	// clear the local interrupt
	XAckhls_InterruptClear(pAccelerator,1);
	resultAvailHlsHw = 1;

	// restart the core if it should run again
	if(runHlsHw)
	{
		enable_interrupt(pAccelerator);
		XAckhls_Start(pAccelerator);
	}
}

// Setup interrupt on ARM PS from FPGA IP instance to ARM PS
int setup_interrupt(XAckhls *pHlsHwIpInstance, XScuGic* pIntCntrlInstance)
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

	if(result != XST_SUCCESS){ 	return result; }

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
							XPAR_FABRIC_ACKHLS_0_INTERRUPT_INTR,
							(Xil_InterruptHandler)hls_hw_isr,
							pHlsHwIpInstance);

	if(result != XST_SUCCESS){ return result;}

	// Enable the Interrupt Source
	XScuGic_Enable(pIntCntrlInstance,XPAR_FABRIC_ACKHLS_0_INTERRUPT_INTR);

	return XST_SUCCESS;
}

// Initialize HLS IP Instance
int hls_hw_init(XAckhls *pHlsHwIpInstance)
{
	int status;
	XAckhls_Config *pCfgHlsHwIp;

	pCfgHlsHwIp  = XAckhls_LookupConfig( XPAR_XACKHLS_0_DEVICE_ID );

	if ( !pCfgHlsHwIp )
	{
		print("ERROR: Lookup of accelerator configuration failed.\n");
		return XST_FAILURE;
	}

	status = XAckhls_CfgInitialize(pHlsHwIpInstance, pCfgHlsHwIp);
	if (status != XST_SUCCESS)
	{
		print("ERROR: Could not initialize accelerator.\n");
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

int main()
{
    int status;
    uint8_t data_in_x;			// ACK input A
    uint64_t data_in_y;			// ACK input B
    uint64_t hw_res_data;		// HW result
    uint64_t sw_res_data;		// SW result
    XAckhls hlsHwInstance;		// HLS IP instance
    XScuGic intCntrlInstance;	// Interrupt controller instance
    int runMode;				// Run mode. 1 - measure avg exec time of ACK on HW and SW, 0 - calculate ACK of two input numbers

    // Always hope for the best!
    status = XST_SUCCESS;

    // Initialize platform
    init_platform();

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

	printf("[ACK on Zynq FPGA(xc7z010clg400-1) and ARM cortex A-9 cpu core]\n");
    do
    {
    	printf("Enter run mode (0 -  Calculate ACK of two user provided numbers, 1-Measure avg ACK execution time on FPGA and ARM CPU core): ");
    	scanf("%d", &runMode);
    	printf("%d\n", runMode);

    	if( (runMode !=0 ) && (runMode !=1 ) )
    	{
    		printf("Illegal mode!!. Please re-enter 0 or 1\n");
    	}
    }while( (runMode !=0 ) && (runMode !=1 )  );

    if( 0 == runMode )
    {
		// Calculate Ackermann function two unsigned numbers X and Y provided by user as inputs on serial console
		printf("Enter X: ");
		scanf("%" SCNu8, &data_in_x);
		printf("%" PRIu8 "\n", data_in_x);

		printf("Enter Y: ");
		scanf("%" SCNu64, &data_in_y);
		printf("%" PRIu64 "\n", data_in_y);

		// Setup user provided data for Ackermann inputs X and Y
		XAckhls_Set_x(&hlsHwInstance, data_in_x);
		XAckhls_Set_y(&hlsHwInstance, data_in_y);

		// Check if HW IP instance is ready
		if(!XAckhls_IsReady(&hlsHwInstance))
		{
			print("HLS HW peripheral is not ready! Exiting.\n");
			exit(-1);
		}

		// Enable the interrupt
		enable_interrupt(&hlsHwInstance);

		// Start the HW IP instance
		XAckhls_Start(&hlsHwInstance);

		// Wait for PS ISR to be triggered by IP Instance
		while(!resultAvailHlsHw); // blocked waiting

		// Read HW result
		hw_res_data = XAckhls_Get_pResult(&hlsHwInstance);

		// Call the software model of the HW IP
		ackArm(data_in_x, data_in_y, &sw_res_data);

		// Check if results are identical
		printf("ACK(X=%" PRIu8 ", Y=%" PRIu64 ") from FPGA HW: %" PRIu64 "\n", data_in_x, data_in_y, hw_res_data );
		printf("ACK(X=%" PRIu8 ", Y=%" PRIu64 ") from ARM CPU core: %" PRIu64 "\n", data_in_x, data_in_y, sw_res_data );
		if( hw_res_data == sw_res_data )
		{
			print("Hardware and software results match!\n");
			status = XST_SUCCESS;
		}
		else
		{
			print("Hardware and software results DONOT match!!!\n");
			status = XST_FAILURE;
		}
    }
    else
    {
		// Measure and report the avg ACK execution time on FPGA and ARM processor core
		XTime timeHwStart,timeHwEnd, timeHwAccum;
		XTime timeSwStart,timeSwEnd, timeSwAccum;

		// Number of iterations over which execution times will be averaged
		int testIterations = 1;

		// Setup fixed data for ACK inputs x and y
		printf("Enter X: ");
		scanf("%" SCNu8, &data_in_x);
		printf("%" PRIu8 "\n", data_in_x);

		printf("Enter Y: ");
		scanf("%" SCNu64, &data_in_y);
		printf("%" PRIu64 "\n", data_in_y);

		printf("Running timing test for %d iterations to measure average execution time. Please wait for results....\n", testIterations);
		timeHwAccum = 0;
		timeSwAccum = 0;
		for(int i = 0; i <testIterations; ++i)
		{
			// Setup input parameters of HLS block
			XAckhls_Set_x(&hlsHwInstance, data_in_x);
			XAckhls_Set_y(&hlsHwInstance, data_in_y);

			// Check if HW IP instance is ready
			if(!XAckhls_IsReady(&hlsHwInstance))
			{
				print("HLS HW peripheral is not ready! Exiting ...\n");
				exit(-1);
			}

			// Enable the interrupt
			enable_interrupt(&hlsHwInstance);

			// Start the HW IP instance
			XTime_GetTime(&timeHwStart);
			XAckhls_Start(&hlsHwInstance);

			// Wait for PS ISR to be triggered by IP Instance
			while(!resultAvailHlsHw); // blocked waiting
			XTime_GetTime(&timeHwEnd);

			// Read HW result
			hw_res_data = XAckhls_Get_pResult(&hlsHwInstance);

			// Accumulate HW execution time on Zynq FPGA
			timeHwAccum += (timeHwEnd-timeHwStart);

			// Call the software model of the HW IP
			XTime_GetTime(&timeSwStart);
			ackArm(data_in_x, data_in_y, &sw_res_data);
			XTime_GetTime(&timeSwEnd);

			// Accumulate SW execution time on ARM CPU core
			timeSwAccum += (timeSwEnd-timeSwStart);

			// Check if results are identical
			printf("ACK(X=%" PRIu8 ", Y=%" PRIu64 ") from FPGA HW: %" PRIu64 "\n", data_in_x, data_in_y, hw_res_data );
			printf("ACK(X=%" PRIu8 ", Y=%" PRIu64 ") from ARM CPU core: %" PRIu64 "\n", data_in_x, data_in_y, sw_res_data );
			if( hw_res_data == sw_res_data )
			{
				print("Hardware and software results match!\n");
				status = XST_SUCCESS;
			}
			else
			{
				print("Hardware and software results DONOT match!!!\n");
				status = XST_FAILURE;
			}
		}
		printf("Done!\n");
		printf("ACK execution on Zynq FPGA: average %llu clock cycles and average time of %e sec.\n", (unsigned long long)((double)timeHwAccum/(double)testIterations), ((double)timeHwAccum)/((double)COUNTS_PER_SECOND *(double)testIterations));
		printf("ACK execution on ARM CPU core: average %llu clock cycles and average time of %e sec.\n", (unsigned long long)((double)timeSwAccum/(double)testIterations), ((double)timeSwAccum)/((double)COUNTS_PER_SECOND *(double)testIterations));
    }

    cleanup_platform();
    return status;
}
