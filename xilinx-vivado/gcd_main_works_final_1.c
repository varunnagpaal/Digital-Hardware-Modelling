/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
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

// Enable IP to PS interrupt and start the IP block
void hls_hw_start(void *pHlsHwIpInstance)
{
	XGcd *pAccelerator = (XGcd *)pHlsHwIpInstance;
	XGcd_InterruptEnable(pAccelerator,1);
	XGcd_InterruptGlobalEnable(pAccelerator);
	XGcd_Start(pAccelerator);
}

// Define IP to PS ISR
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

// Setup interrupt from FPGA IP instance to PS
int setup_interrupt(XGcd *pHlsHwIpInstance, XScuGic* pIntCntrlInstance)
{
	if( !pHlsHwIpInstance || !pIntCntrlInstance ){ return XST_FAILURE; }

	//This functions sets up the interrupt on the Arm
	int result;
	XScuGic_Config *pCfgGic = XScuGic_LookupConfig(XPAR_SCUGIC_SINGLE_DEVICE_ID);

	if (pCfgGic == NULL)
	{
		print("Interrupt Configuration Lookup Failed\n\r");
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
	print("Register the exception handler\n\r");
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
								(Xil_ExceptionHandler)XScuGic_InterruptHandler,
								pIntCntrlInstance);

	//Enable the exception handler
	Xil_ExceptionEnable();

	// Connect the Adder ISR to the exception table
	print("Connect the ISR to the Exception handler table\n\r");
	result = XScuGic_Connect(pIntCntrlInstance,
							XPAR_FABRIC_GCD_0_INTERRUPT_INTR,
							(Xil_InterruptHandler)hls_hw_isr,
							pHlsHwIpInstance);

	if(result != XST_SUCCESS){ return result;}

	print("Enable the ISR\n\r");
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
		print("ERROR: Lookup of accelerator configuration failed.\n\r");
		return XST_FAILURE;
	}

	status = XGcd_CfgInitialize(pHlsHwIpInstance, pCfgHlsHwIp);
	if (status != XST_SUCCESS)
	{
		print("ERROR: Could not initialize accelerator.\n\r");
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

int main()
{
    init_platform();
    int status;
    int data_in_a;
    int data_in_b;
    volatile int hw_res_valid = 0;
    int hw_res_data;
    int sw_res_data;

    printf("Hello World\n\r");

    // HLS IP instance
    XGcd hlsHwInstance;

    // Interrupt controller instance
    XScuGic intCntrlInstance;

    status = hls_hw_init(&hlsHwInstance);
    if( status != XST_SUCCESS )
    {
    	print("HLS peripheral setup failed\n\r");
    	exit(-1);
    }

    // Setup the interrupt
    status = setup_interrupt(&hlsHwInstance, &intCntrlInstance);
    if( status != XST_SUCCESS )
    {
    	print("PS ISR setup failed\n\r");
    	exit(-1);
    }

    // Setup input parameters of HLS block
    data_in_a = 60;
    data_in_b = 36;
    XGcd_Set_a(&hlsHwInstance, data_in_a);
    XGcd_Set_b(&hlsHwInstance, data_in_b);

    if(XGcd_IsReady(&hlsHwInstance))
    {
    	print("HLS HW peripheral is ready. Starting ...");
    }
    else
    {
    	print("HLS HW peripheral is not ready! Exiting ...\n\r");
    	exit(-1);
    }

    //  Interrupt driven
    hls_hw_start(&hlsHwInstance);

    // Wait for PS ISR to be triggered by IP Instance
    while(!resultAvailHlsHw); // blocked waiting

    hw_res_data = XGcd_Get_pResult(&hlsHwInstance);

    // Call the software model of the HW IP
    gcd_sw_model(data_in_a, data_in_b, &sw_res_data);

    // Check if results are identical
    if( hw_res_data == sw_res_data )
    {
    	print("Hardware and software results match!\n\r");
    	status = XST_SUCCESS;
    }
    else
    {
    	print("Hardware and software results DONOT match!!!\n\r");
    	status = XST_FAILURE;
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
   print("Program to test communication with HLS MACC block in PL\n\r");
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
   	print("HLS peripheral setup failed\n\r");
   	exit(-1);
   }

   //Setup the interrupt
   status = setup_interrupt(&hlsHwInstance, &intCntrlInstance);
   if(status != XST_SUCCESS){
      print("Interrupt setup failed\n\r");
      exit(-1);
   }

   XGcd_Set_a(&hlsHwInstance, a);
   XGcd_Set_b(&hlsHwInstance, b);

   if (XGcd_IsReady(&hlsHwInstance))
      print("HLS peripheral is ready.  Starting... ");
   else {
      print("!!! HLS peripheral is not ready! Exiting...\n\r");
      exit(-1);
   }

   if (1) { // use interrupt
	   hls_hw_start(&hlsHwInstance);
      while(!resultAvailHlsHw)
         ; // spin
      res_hw = XGcd_Get_pResult(&hlsHwInstance);
      print("Interrupt received from HLS HW.\n\r");
   } else { // Simple non-interrupt driven test
      XGcd_Start(&hlsHwInstance);
      do {
         res_hw = XGcd_Get_pResult(&hlsHwInstance);
      } while (!XGcd_IsReady(&hlsHwInstance));
      print("Detected HLS peripheral complete. Result received.\n\r");
   }

   //call the software version of the function
   gcd_sw_model (a, b, &res_sw );

   printf("Result from HW: %d; Result from SW: %d\n\r", res_hw, res_sw);
   if (res_hw == res_sw) {
      print("*** Results match ***\n\r");
      status = 0;
   }
   else {
      print("!!! MISMATCH !!!\n\r");
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
		print("ERROR: Lookup of accelerator configuration failed.\n\r");
		return XST_FAILURE;
	}

	status = XGcd_CfgInitialize(pHlsHwIpInstance, pCfgHlsHwIp);
	if (status != XST_SUCCESS)
	{
		print("ERROR: Could not initialize accelerator.\n\r");
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
		print("Interrupt Configuration Lookup Failed\n\r");
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
	print("Register the exception handler\n\r");
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
								(Xil_ExceptionHandler)XScuGic_InterruptHandler,
								pIntCntrlInstance);

	//Enable the exception handler
	Xil_ExceptionEnable();

	// Connect the Adder ISR to the exception table
	print("Connect the ISR to the Exception handler table\n\r");
	result = XScuGic_Connect(pIntCntrlInstance,
							XPAR_FABRIC_GCD_0_INTERRUPT_INTR,
							(Xil_InterruptHandler)hls_hw_isr,
							pHlsHwIpInstance);

	if(result != XST_SUCCESS){ return result;}

	print("Enable the ISR\n\r");
	XScuGic_Enable(pIntCntrlInstance,XPAR_FABRIC_GCD_0_INTERRUPT_INTR);

	return XST_SUCCESS;
}
*/

