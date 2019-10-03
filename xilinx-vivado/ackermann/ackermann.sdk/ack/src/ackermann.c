/*
 * ackermann.c: Calculates Ackermann function of two numbers on Zynq FPGA and ARM
 *
 *
 * Author	: Nagpal, Varun
 * Date		: Oct, 03rd 2019
 *
 * Usage:	1. User is asked to enter range of x and y for which Ackerman function A(x,y) is to be computed
 * 		  	2. For each pair of x and y in the given range, the function A(x,y) is computed on ARM and FPGA
 * 		  	3. Actual computed values produced on ARM (produced by custom SW model) and FPGA are compared
 * 		       against ideal or expected values (generated on ARM using appropriate formulae)
 * 		  	4. For computations on ARM CPU core, computation time is averaged for number of iterations
 * 		       which are automatically computed keeping in mind expected order of computation time for A(x,y).
 * 		  	5. For computation on FPGA, computation time is measured only for one iteration. This is because
 * 		       fixed circuit architecture guarantees almost no variation in computation time for same inputs
 * 		       on multiple iterations.
 * 		  	6. If for given x and y, A(x,y) is computationally infeasible, its computation is simply skipped
 * 		       for FPGA and ARM CPu core.
 *
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

#include <stdlib.h> 		// Standard C functions, e.g. exit()
#include <stdbool.h> 		// Provides a Boolean data type for ANSI/ISO-C
#include "xparameters.h" 	// Parameter definitions for processor peripherals
#include "xscugic.h" 		// Processor interrupt controller device driver
#include "xackhls.h" 		// Device driver for HLS HW block
#include "xil_assert.h"
#include "xtime_l.h"		// Used to measure time (ARM cc's) a function
#include <inttypes.h>		// To print uintx_t and intx_t types properly using printf

#define N 9

// To interface with ISR
volatile static int runHlsHw = 0;
volatile static int resultAvailHlsHw = 0;

void ackArmCustom(uint8_t x, uint64_t y, uint64_t *pResult)
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

void ackArmIdeal(uint8_t x, uint64_t y, uint64_t *pVal)
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

uint16_t getTestIterations(uint8_t x, uint64_t y)
{
	uint16_t testIterations;

	switch(x)
	{
	case 0:
	case 1:
	case 2:
		testIterations = 1000;
		break;

	case 3:
		if( y >= 0 && y < 10) 		testIterations = 1000;
		else if( y >= 10 && y < 20)	testIterations = 100;
		else if( y >= 20 && y < 25)	testIterations = 2;
		else if( y >= 25 && y < 31)	testIterations = 1;
		else 						testIterations = 0;
		break;

	case 4:
		if( y >= 0 && y < 2) 		testIterations = 1000;
		else 						testIterations = 0;
		break;

	case 5:
		if ( y == 0 ) 				testIterations = 1000;
		else 						testIterations = 0;
		break;

	default:
		testIterations = 0;
		break;
	}

	return testIterations;
}

int main()
{
    int status;
    XAckhls hlsHwInstance;		// HLS IP instance
    XScuGic intCntrlInstance;	// Interrupt controller instance

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

	printf("[Ackermann Function A(x, y) on Zynq FPGA(xc7z010clg400-1) and ARM Cortex A-9 CPU Core]\n");

	char ch;
	do{
	    uint64_t sw_ideal_result;	// ARM SW ideal or expected result
	    uint64_t sw_custm_result;	// ARM SW custom or actual result
	    uint64_t hw_result;			// FPGA HW actual result

		uint8_t x_min_in;
		uint8_t x_max_in;
		uint64_t y_min_in;
		uint64_t y_max_in;

		do{
			printf("Enter minimum value of x (0 <= x <= 5): ");
			scanf("%" SCNu8, &x_min_in);
			printf("%" PRIu8 "\n", x_min_in);
		}while( x_min_in > 5 );

		do{
			printf("Enter maximum value of x (%" PRIu8 " <= x <= 5): ", x_min_in);
			scanf("%" SCNu8, &x_max_in);
			printf("%" PRIu8 "\n", x_max_in);
		}while( x_max_in < x_min_in );

		printf("Enter minimum value of y (0 <= y): ");
		scanf("%" SCNu64, &y_min_in);
		printf("%" PRIu64"\n", y_min_in);

		do{
			printf("Enter maximum value of y (%" SCNu64 " <= y): ", y_min_in);
			scanf("%" SCNu64, &y_max_in);
			printf("%" PRIu64 "\n", y_max_in);
		}while( y_max_in < y_min_in );

		printf("A(x,y),ARM-ideal(value),ARM-custom(value),FPGA(value),PASS/FAIL,Iterations,ARM-ideal(cc),ARM-ideal(sec),ARM-custom(cc),ARM-custom(sec),FPGA(cc),FPGA(sec)\n");

		for( uint8_t x = x_min_in; x <= x_max_in; ++x)
		{
			for( uint64_t y = y_min_in; y <= y_max_in; ++y)
			{
				// Number of iterations over which execution times of A(x,y) will be averaged on ARM CPU core
				uint16_t testIterations = getTestIterations(x,y);

				// We don't run any iterations of functions which are infeasible to compute
				if( 0 == testIterations ) continue;

				// Measure and report the ACK execution time on ARM(ideal), ARM(custom) and FPGA
				XTime timeSwIdealStart = 0;
				XTime timeSwIdealEnd = 0;
				XTime timeSwIdealAccum = 0;
				XTime timeSwCustmStart = 0;
				XTime timeSwCustmEnd = 0;
				XTime timeSwCustmAccum = 0;
				XTime timeHwStart = 0;
				XTime timeHwEnd = 0;
				XTime timeHw = 0;

				for(int i = 0; i < testIterations; ++i)
				{
					// Call the Ideal SW model of HW IP on ARM CPU core
					XTime_GetTime(&timeSwIdealStart);
					ackArmIdeal(x, y, &sw_ideal_result);
					XTime_GetTime(&timeSwIdealEnd);

					// Accumulate execution time of Ideal SW model on ARM CPU core
					timeSwIdealAccum += (timeSwIdealEnd-timeSwIdealStart);

					// Call the Custom SW model of HW IP on ARM CPU core
					XTime_GetTime(&timeSwCustmStart);
					ackArmCustom(x, y, &sw_custm_result);
					XTime_GetTime(&timeSwCustmEnd);

					// Accumulate execution time of Custom SW model on ARM CPU core
					timeSwCustmAccum += (timeSwCustmEnd-timeSwCustmStart);

					if( i == 0)
					{
						// We compute A(x,y) on FPGA only once as its hardware circuit is fixed
						// and would return results in same time (cc or sec) for any iteration.

						// Setup input parameters of FPGA HW IP block
						XAckhls_Set_x(&hlsHwInstance, x);
						XAckhls_Set_y(&hlsHwInstance, y);

						// Check if FPGA HW IP instance is ready
						if(!XAckhls_IsReady(&hlsHwInstance))
						{
							print("FPGA HLS HW IP HW peripheral is not ready! Exiting ...\n");
							status = XST_FAILURE;
							break;
						}

						// Enable the interrupt
						enable_interrupt(&hlsHwInstance);

						// Start the HW IP instance
						XTime_GetTime(&timeHwStart);
						XAckhls_Start(&hlsHwInstance);

						// Wait for PS ISR to be triggered by IP Instance
						while(!resultAvailHlsHw); // blocked waiting
						XTime_GetTime(&timeHwEnd);

						// Reset hw result available flag
						resultAvailHlsHw = 0;

						// Read HW result
						hw_result = XAckhls_Get_pResult(&hlsHwInstance);

						// Get HW execution time on Zynq FPGA
						timeHw += (timeHwEnd-timeHwStart);

						// A(x,y)
						printf("A(%" PRIu8 ",%" PRIu64 "),", x, y);

						// ARM-ideal(value)
						printf("%" PRIu64 ",", sw_ideal_result);

						// ARM-custom(value)
						printf("%" PRIu64 ",", sw_custm_result);

						// FPGA(value)
						printf("%" PRIu64 ",", hw_result);

						// PASS/FAIL
						if( sw_custm_result != sw_ideal_result)
						{
							printf("FAIL(ARM),");
							status = XST_FAILURE;
							break;
						}
						else if( hw_result != sw_ideal_result)
						{
							printf("FAIL(FPGA),");
							status = XST_FAILURE;
							break;
						}
						else
						{
							printf("PASS,");
							status = XST_SUCCESS;
						}

						// Iterations
						printf("%" PRIu16 ",", testIterations);
					}
				}

				// ARM-ideal(cc) ARM-ideal(sec) ARM-custom(cc) ARM-custom(sec)
				printf("%llu,%e,",
						(unsigned long long)((double)timeSwIdealAccum/(double)testIterations),
						((double)timeSwIdealAccum)/((double)COUNTS_PER_SECOND *(double)testIterations));

				// ARM-custom(cc) ARM-custom(sec)
				printf("%llu,%e,",
						(unsigned long long)((double)timeSwCustmAccum/(double)testIterations),
						((double)timeSwCustmAccum)/((double)COUNTS_PER_SECOND *(double)testIterations));

				// FPGA(cc) FPGA(sec)
				printf("%llu,%e",
						(unsigned long long)((double)timeHw/(double)testIterations),
						((double)timeHw)/((double)COUNTS_PER_SECOND *(double)testIterations));

				printf("\n");
			}
		}

		printf("Done!\n");
		printf("Do you wish to restart (y/Y, n/N) ? ");
		scanf("%c", &ch);
		printf("%c\n", ch);
	}while( (ch == 'y' || ch == 'Y') && !(ch == 'n' || ch == 'N'));


    cleanup_platform();
    return status;
}
