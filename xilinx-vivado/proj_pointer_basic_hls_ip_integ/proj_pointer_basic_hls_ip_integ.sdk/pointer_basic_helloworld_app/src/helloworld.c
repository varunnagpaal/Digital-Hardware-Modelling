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
#include "xpointer_basic.h" // Device driver for HLS HW block
#include "xil_assert.h"

// To interface with ISR
volatile static int runHlsHw = 0;
volatile static int resultAvailHlsHw = 0;

// Software model of the HLS HW IP
void sw_model( int data_in, int* data_out )
{
  static int acc = 0;

  acc += data_in;
  *data_out  = acc;
}

// Enable IP to PS interrupt and start the IP block
void hls_hw_start(void *pHlsHwIpInstance)
{
	XPointer_basic *pAccelerator = (XPointer_basic *)pHlsHwIpInstance;
	XPointer_basic_InterruptEnable(pAccelerator,1);
	XPointer_basic_InterruptGlobalEnable(pAccelerator);
	XPointer_basic_Start(pAccelerator);
}

// Define IP to PS ISR
void hls_hw_isr(void *pHlsHwIpInstance)
{
	XPointer_basic *pAccelerator = (XPointer_basic *)pHlsHwIpInstance;

	//Disable the global interrupt
	XPointer_basic_InterruptGlobalDisable(pAccelerator);

	//Disable the local interrupt
	XPointer_basic_InterruptDisable(pAccelerator,0xffffffff);

	// clear the local interrupt
	XPointer_basic_InterruptClear(pAccelerator,1);
	resultAvailHlsHw = 1;

	// restart the core if it should run again
	if(runHlsHw)
	{
		hls_hw_start(pAccelerator);
	}
}

// Setup interrupt from FPGA IP instance to PS
int setup_interrupt(XPointer_basic *pHlsHwIpInstance, XScuGic* pIntCntrlInstance)
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
							XPAR_FABRIC_POINTER_BASIC_0_INTERRUPT_INTR,
							(Xil_InterruptHandler)hls_hw_isr,
							pHlsHwIpInstance);

	if(result != XST_SUCCESS){ return result;}

	print("Enable the ISR\n\r");
	XScuGic_Enable(pIntCntrlInstance,XPAR_FABRIC_POINTER_BASIC_0_INTERRUPT_INTR);

	return XST_SUCCESS;
}

// Initialize HLS IP Instance
int hls_hw_init(XPointer_basic *pHlsHwIpInstance)
{
	int status;
	XPointer_basic_Config *pCfgHlsHwIp;

	pCfgHlsHwIp  = XPointer_basic_LookupConfig( XPAR_XPOINTER_BASIC_0_DEVICE_ID );

	if ( !pCfgHlsHwIp )
	{
		print("ERROR: Lookup of accelerator configuration failed.\n\r");
		return XST_FAILURE;
	}

	status = XPointer_basic_CfgInitialize(pHlsHwIpInstance, pCfgHlsHwIp);
	if (status != XST_SUCCESS)
	{
		print("ERROR: Could not initialize accelerator.\n\r");
		return XST_FAILURE;
	}
}

int main()
{
    init_platform();
    int status;
    int data_in = 10;
    volatile int hw_res_valid = 0;
    int hw_res_data;
    int sw_res_data;

    print("Hello World\n\r");

    // HLS IP instance
    XPointer_basic hlsHwInstance;

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
    XPointer_basic_Set_d_i(&hlsHwInstance, data_in);

    if(XPointer_basic_IsReady(&hlsHwInstance))
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
    while(!resultAvailHlsHw ||
    	  !(hw_res_valid = XPointer_basic_Get_d_o_vld(&hlsHwInstance))); // blocked waiting

    hw_res_data = XPointer_basic_Get_d_o(&hlsHwInstance);

    // Call the software model of the HW IP
    sw_model(data_in, &sw_res_data);

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
