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