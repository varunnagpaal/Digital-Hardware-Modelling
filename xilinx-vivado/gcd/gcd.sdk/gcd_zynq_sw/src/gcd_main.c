/*
 * gcd_main.c: Calculates GCD of two numbers on Zynq FPGA and ARM
 *
 *
 * Name: Nagpal, Varun
 * Date: Sept, 10th 2019
 *
 * Usage: The code can be run in two modes.
 * 	1. Calculate GCD of two numbers A and B provided by user on serial terminal for both Zynq FPGA and ARM CPU core.
 * 	2. Report average execution time for calculating GCD on both Zynq FPGA and ARM CPU core.
 *
 *	To run Mode 1, set variable MEASURE_EXEC_TIME to 0 (default)
 * 	To run Mode 2, set variable MEASURE_EXEC_TIME to 1
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
#include "xgcd.h" // Device driver for HLS HW block
#include "xil_assert.h"
#include "xtime_l.h"

#define MEASURE_EXEC_TIME 0

// To interface with ISR
volatile static int runHlsHw = 0;
volatile static int resultAvailHlsHw = 0;

// Software model of the HLS HW IP
void gcd_sw_model (int a, int b, int *pResult )
{
	int result = a;

	while( a != b )
	{
		if( a > b )
		{
			a = a-b;
		}
		else
		{
			b = b-a;
		}
	}
	result = a;
	*pResult = result;
}

// Enable PL to PS interrupt
void enable_interrupt(void *pHlsHwIpInstance)
{
	XGcd *pAccelerator = (XGcd *)pHlsHwIpInstance;
	XGcd_InterruptEnable(pAccelerator,1);
	XGcd_InterruptGlobalEnable(pAccelerator);
}

// Define PL to PS ISR
void hls_hw_isr(void *pHlsHwIpInstance)
{
	XGcd *pAccelerator = (XGcd *)pHlsHwIpInstance;

	//Disable the global interrupt
	XGcd_InterruptGlobalDisable(pAccelerator);

	//Disable the local interrupt
	XGcd_InterruptDisable(pAccelerator,0xffffffff);

	// clear the local interrupt
	XGcd_InterruptClear(pAccelerator,1);
	resultAvailHlsHw = 1;

	// restart the core if it should run again
	if(runHlsHw)
	{
		enable_interrupt(pAccelerator);
		XGcd_Start(pAccelerator);
	}
}

// Setup interrupt on ARM PS from FPGA IP instance to ARM PS
int setup_interrupt(XGcd *pHlsHwIpInstance, XScuGic* pIntCntrlInstance)
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
							XPAR_FABRIC_GCD_0_INTERRUPT_INTR,
							(Xil_InterruptHandler)hls_hw_isr,
							pHlsHwIpInstance);

	if(result != XST_SUCCESS){ return result;}

	// Enable the Interrupt Source
	XScuGic_Enable(pIntCntrlInstance,XPAR_FABRIC_GCD_0_INTERRUPT_INTR);

	return XST_SUCCESS;
}

// Initialize HLS IP Instance
int hls_hw_init(XGcd *pHlsHwIpInstance)
{
	int status;
	XGcd_Config *pCfgHlsHwIp;

	pCfgHlsHwIp  = XGcd_LookupConfig( XPAR_XGCD_0_DEVICE_ID );

	if ( !pCfgHlsHwIp )
	{
		print("ERROR: Lookup of accelerator configuration failed.\n");
		return XST_FAILURE;
	}

	status = XGcd_CfgInitialize(pHlsHwIpInstance, pCfgHlsHwIp);
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
    int data_in_a;				// GCD input A
    int data_in_b;				// GCD input B
    int hw_res_data;			// HW result
    int sw_res_data;			// SW result
    XGcd hlsHwInstance;			// HLS IP instance
    XScuGic intCntrlInstance;	// Interrupt controller instance
    int runMode;				// Run mode. 1 - measure avg exec time on HW and SW, 0 - calculate GCD of two input numbers

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

	printf("[GCD on Zynq FPGA(xc7z010clg400-1) and ARM cortex A-9 cpu core]\n");
    do
    {
    	printf("Enter run mode (0 -  Calculate GCD of two user provided numbers, 1-Measure avg GCD execution time on FPGA and ARM CPU core): ");
    	scanf("%d", &runMode);
    	printf("%d\n", runMode);

    	if( (runMode !=0 ) && (runMode !=1 ) )
    	{
    		printf("Illegal mode!!. Please re-enter 0 or 1\n");
    	}
    }while( (runMode !=0 ) && (runMode !=1 )  );

    if( 0 == runMode )
    {
		// Calculate GCD of 16-bit unsigned numbers A and B provided by user as inputs on serial console
		printf("Enter A: ");
		scanf("%d", &data_in_a);
		printf("%d\n", data_in_a);

		printf("Enter B: ");
		scanf("%d", &data_in_b);
		printf("%d\n", data_in_b);


		// Setup user provided data for GCD inputs a and b
		XGcd_Set_a(&hlsHwInstance, data_in_a);
		XGcd_Set_b(&hlsHwInstance, data_in_b);

		// Check if HW IP instance is ready
		if(!XGcd_IsReady(&hlsHwInstance))
		{
			print("HLS HW peripheral is not ready! Exiting.\n");
			exit(-1);
		}

		// Enable the interrupt
		enable_interrupt(&hlsHwInstance);

		// Start the HW IP instance
		XGcd_Start(&hlsHwInstance);

		// Wait for PS ISR to be triggered by IP Instance
		while(!resultAvailHlsHw); // blocked waiting

		// Read HW result
		hw_res_data = XGcd_Get_pResult(&hlsHwInstance);

		// Call the software model of the HW IP
		gcd_sw_model(data_in_a, data_in_b, &sw_res_data);

		// Check if results are identical
		printf("GCD(A=%d, B=%d) from FPGA HW: %d\n", data_in_a, data_in_b, hw_res_data );
		printf("GCD(A=%d, B=%d) from ARM CPU core: %d\n", data_in_a, data_in_b, sw_res_data );
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
		// Measure and report the avg GCD execution time on FPGA and ARM processor core
		XTime timeHwStart,timeHwEnd, timeHwAccum;
		XTime timeSwStart,timeSwEnd, timeSwAccum;

		// Number of iterations over which execution times will be averaged
		int testIterations = 10000000;

		// Setup fixed data for GCD inputs a and b
		data_in_a = 60;
		data_in_b = 36;

		printf("Running timing test for %d iterations to measure average execution time. Please wait for results....\n", testIterations);
		timeHwAccum = 0;
		timeSwAccum = 0;
		for(int i = 0; i <testIterations; ++i)
		{
			// Setup input parameters of HLS block
			XGcd_Set_a(&hlsHwInstance, data_in_a);
			XGcd_Set_b(&hlsHwInstance, data_in_b);

			// Check if HW IP instance is ready
			if(!XGcd_IsReady(&hlsHwInstance))
			{
				print("HLS HW peripheral is not ready! Exiting ...\n");
				exit(-1);
			}

			// Enable the interrupt
			enable_interrupt(&hlsHwInstance);

			// Start the HW IP instance
			XTime_GetTime(&timeHwStart);
			XGcd_Start(&hlsHwInstance);

			// Wait for PS ISR to be triggered by IP Instance
			while(!resultAvailHlsHw); // blocked waiting
			XTime_GetTime(&timeHwEnd);

			// Read HW result
			hw_res_data = XGcd_Get_pResult(&hlsHwInstance);

			// Accumulate HW execution time on Zynq FPGA
			timeHwAccum += (timeHwEnd-timeHwStart);

			// Call the software model of the HW IP
			XTime_GetTime(&timeSwStart);
			gcd_sw_model(data_in_a, data_in_b, &sw_res_data);
			XTime_GetTime(&timeSwEnd);

			// Accumulate SW execution time on ARM CPU core
			timeSwAccum += (timeSwEnd-timeSwStart);

			// Check if Zynq FPGA HW and ARM CPU core SW results are identical
			if( hw_res_data != sw_res_data )
			{
				printf("Failed!!!\n");
				print("Hardware and software results DONOT match!!!. Exiting.\n");
				exit(-1);
			}
		}
		printf("Done!\n");
		printf("GCD execution on Zynq FPGA: average %llu clock cycles and average time of %e sec.\n", (unsigned long long)((double)timeHwAccum/(double)testIterations), ((double)timeHwAccum)/((double)COUNTS_PER_SECOND *(double)testIterations));
		printf("GCD execution on ARM CPU core: average %llu clock cycles and average time of %e sec.\n", (unsigned long long)((double)timeSwAccum/(double)testIterations), ((double)timeSwAccum)/((double)COUNTS_PER_SECOND *(double)testIterations));
    }

    cleanup_platform();
    return status;
}




/*


#include <stdio.h>
#include "platform.h"
// Add BSP header files
#include <stdlib.h>  // Standard C functions, e.g. exit()
#include <stdbool.h> // Provides a Boolean data type for ANSI/ISO-C
#include "xparameters.h" // Parameter definitions for processor periperals
#include "xscugic.h"     // Processor interrupt controller device driver
#include "xgcd.h"   // Device driver for HLS HW block

// Global variable definitions - used by ISR
volatile static int runHlsHw = 0;
volatile static int resultAvailHlsHw = 0;

// Setup and helper functions
int setup_interrupt(XGcd *pHlsHwIpInstance, XScuGic* pIntCntrlInstance);
int hls_hw_init(XGcd *pHlsHwIpInstance);
void hls_hw_start(void *pHlsHwIpInstance);
// The ISR prototype
void gcd_isr(void *InstancePtr);
// Software model of HLS hardware
void gcd_sw_model (int a, int b, int *pResult );

int main()
{
   print("Program to test communication with HLS MACC block in PL\n");
   int a = 60, b = 36;
   int res_hw;
   int res_sw;
   int status;

   // VNG
   init_platform();

   XGcd hlsHwInstance;
   XScuGic intCntrlInstance;

   status = hls_hw_init(&hlsHwInstance);
   if( status != XST_SUCCESS )
   {
   	print("HLS peripheral setup failed\n");
   	exit(-1);
   }

   //Setup the interrupt
   status = setup_interrupt(&hlsHwInstance, &intCntrlInstance);
   if(status != XST_SUCCESS){
      print("Interrupt setup failed\n");
      exit(-1);
   }

   XGcd_Set_a(&hlsHwInstance, a);
   XGcd_Set_b(&hlsHwInstance, b);

   if (XGcd_IsReady(&hlsHwInstance))
      print("HLS peripheral is ready.  Starting... ");
   else {
      print("!!! HLS peripheral is not ready! Exiting...\n");
      exit(-1);
   }

   if (1) { // use interrupt
	   hls_hw_start(&hlsHwInstance);
      while(!resultAvailHlsHw)
         ; // spin
      res_hw = XGcd_Get_pResult(&hlsHwInstance);
      print("Interrupt received from HLS HW.\n");
   } else { // Simple non-interrupt driven test
      XGcd_Start(&hlsHwInstance);
      do {
         res_hw = XGcd_Get_pResult(&hlsHwInstance);
      } while (!XGcd_IsReady(&hlsHwInstance));
      print("Detected HLS peripheral complete. Result received.\n");
   }

   //call the software version of the function
   gcd_sw_model (a, b, &res_sw );

   printf("Result from HW: %d; Result from SW: %d\n", res_hw, res_sw);
   if (res_hw == res_sw) {
      print("*** Results match ***\n");
      status = 0;
   }
   else {
      print("!!! MISMATCH !!!\n");
      status = -1;
   }

   cleanup_platform();
   return status;
}

void gcd_sw_model (int a, int b, int *pResult )
{
	int result = a;

	while( a != b )
	{
		if( a > b )
		{
			a = a-b;
		}
		else
		{
			b = b-a;
		}
	}
	result = a;
	*pResult = result;
}

int hls_hw_init(XGcd *pHlsHwIpInstance)
{
	int status;
	XGcd_Config *pCfgHlsHwIp;

	pCfgHlsHwIp  = XGcd_LookupConfig( XPAR_XGCD_0_DEVICE_ID );

	if ( !pCfgHlsHwIp )
	{
		print("ERROR: Lookup of accelerator configuration failed.\n");
		return XST_FAILURE;
	}

	status = XGcd_CfgInitialize(pHlsHwIpInstance, pCfgHlsHwIp);
	if (status != XST_SUCCESS)
	{
		print("ERROR: Could not initialize accelerator.\n");
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}


void hls_hw_start(void *pHlsHwIpInstance)
{
	XGcd *pAccelerator = (XGcd *)pHlsHwIpInstance;
	XGcd_InterruptEnable(pAccelerator,1);
	XGcd_InterruptGlobalEnable(pAccelerator);
	XGcd_Start(pAccelerator);
}

void hls_hw_isr(void *pHlsHwIpInstance)
{
	XGcd *pAccelerator = (XGcd *)pHlsHwIpInstance;

	//Disable the global interrupt
	XGcd_InterruptGlobalDisable(pAccelerator);

	//Disable the local interrupt
	XGcd_InterruptDisable(pAccelerator,0xffffffff);

	// clear the local interrupt
	XGcd_InterruptClear(pAccelerator,1);
	resultAvailHlsHw = 1;

	// restart the core if it should run again
	if(runHlsHw)
	{
		hls_hw_start(pAccelerator);
	}
}

int setup_interrupt(XGcd *pHlsHwIpInstance, XScuGic* pIntCntrlInstance)
{
	if( !pHlsHwIpInstance || !pIntCntrlInstance ){ return XST_FAILURE; }

	//This functions sets up the interrupt on the Arm
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
	print("Register the exception handler\n");
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
								(Xil_ExceptionHandler)XScuGic_InterruptHandler,
								pIntCntrlInstance);

	//Enable the exception handler
	Xil_ExceptionEnable();

	// Connect the Adder ISR to the exception table
	print("Connect the ISR to the Exception handler table\n");
	result = XScuGic_Connect(pIntCntrlInstance,
							XPAR_FABRIC_GCD_0_INTERRUPT_INTR,
							(Xil_InterruptHandler)hls_hw_isr,
							pHlsHwIpInstance);

	if(result != XST_SUCCESS){ return result;}

	print("Enable the ISR\n");
	XScuGic_Enable(pIntCntrlInstance,XPAR_FABRIC_GCD_0_INTERRUPT_INTR);

	return XST_SUCCESS;
}
*/

