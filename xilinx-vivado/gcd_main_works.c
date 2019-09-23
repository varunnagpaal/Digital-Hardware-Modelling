#include <stdio.h>
#include "platform.h"
// Add BSP header files
#include <stdlib.h>  // Standard C functions, e.g. exit()
#include <stdbool.h> // Provides a Boolean data type for ANSI/ISO-C
#include "xparameters.h" // Parameter definitions for processor periperals
#include "xscugic.h"     // Processor interrupt controller device driver
#include "xgcd.h"   // Device driver for HLS HW block

// HLS macc HW instance
XGcd GcdIpInstance;
//Interrupt Controller Instance
XScuGic ScuGic;
// Global variable definitions - used by ISR
volatile static int RunGcdIpInstance = 0;
volatile static int ResultAvailGcdIpInstance = 0;

// Setup and helper functions
int setup_interrupt();
int gcd_init(XGcd *gcdPtr);
void gcd_start(void *InstancePtr);
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

   //Setup the matrix mult
   status = gcd_init(&GcdIpInstance);
   if(status != XST_SUCCESS){
      print("HLS peripheral setup failed\n\r");
      exit(-1);
   }
   //Setup the interrupt
   status = setup_interrupt();
   if(status != XST_SUCCESS){
      print("Interrupt setup failed\n\r");
      exit(-1);
   }

   //set the input parameters of the HLS block
   XGcd_Set_a(&GcdIpInstance, a);
   XGcd_Set_b(&GcdIpInstance, b);
//   XGcd_Set_accum_clr(&GcdIpInstance, 1);

   if (XGcd_IsReady(&GcdIpInstance))
      print("HLS peripheral is ready.  Starting... ");
   else {
      print("!!! HLS peripheral is not ready! Exiting...\n\r");
      exit(-1);
   }

   if (1) { // use interrupt
      gcd_start(&GcdIpInstance);
      while(!ResultAvailGcdIpInstance)
         ; // spin
      res_hw = XGcd_Get_pResult(&GcdIpInstance);
      print("Interrupt received from HLS HW.\n\r");
   } else { // Simple non-interrupt driven test
      XGcd_Start(&GcdIpInstance);
      do {
         res_hw = XGcd_Get_pResult(&GcdIpInstance);
      } while (!XGcd_IsReady(&GcdIpInstance));
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

int gcd_init(XGcd *gcdPtr)
{
   XGcd_Config *cfgPtr;
   int status;

   cfgPtr = XGcd_LookupConfig(XPAR_XGCD_0_DEVICE_ID);
   if (!cfgPtr) {
      print("ERROR: Lookup of acclerator configuration failed.\n\r");
      return XST_FAILURE;
   }
   status = XGcd_CfgInitialize(gcdPtr, cfgPtr);
   if (status != XST_SUCCESS) {
      print("ERROR: Could not initialize accelerator.\n\r");
      return XST_FAILURE;
   }
   return status;
}

void gcd_start(void *InstancePtr){
   XGcd *pAccelerator = (XGcd *)InstancePtr;
   XGcd_InterruptEnable(pAccelerator,1);
   XGcd_InterruptGlobalEnable(pAccelerator);
   XGcd_Start(pAccelerator);
}

void gcd_isr(void *InstancePtr){
   XGcd *pAccelerator = (XGcd *)InstancePtr;

   //Disable the global interrupt
   XGcd_InterruptGlobalDisable(pAccelerator);
   //Disable the local interrupt
   XGcd_InterruptDisable(pAccelerator,0xffffffff);

   // clear the local interrupt
   XGcd_InterruptClear(pAccelerator,1);

   ResultAvailGcdIpInstance = 1;
   // restart the core if it should run again
   if(RunGcdIpInstance){
      gcd_start(pAccelerator);
   }
}

int setup_interrupt()
{
   //This functions sets up the interrupt on the ARM
   int result;
   XScuGic_Config *pCfg = XScuGic_LookupConfig(XPAR_SCUGIC_SINGLE_DEVICE_ID);
   if (pCfg == NULL){
      print("Interrupt Configuration Lookup Failed\n\r");
      return XST_FAILURE;
   }
   result = XScuGic_CfgInitialize(&ScuGic,pCfg,pCfg->CpuBaseAddress);
   if(result != XST_SUCCESS){
      return result;
   }
   // self test
   result = XScuGic_SelfTest(&ScuGic);
   if(result != XST_SUCCESS){
      return result;
   }
   // Initialize the exception handler
   Xil_ExceptionInit();
   // Register the exception handler
   //print("Register the exception handler\n\r");
   Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,(Xil_ExceptionHandler)XScuGic_InterruptHandler,&ScuGic);
   //Enable the exception handler
   Xil_ExceptionEnable();
   // Connect the Adder ISR to the exception table
   //print("Connect the Adder ISR to the Exception handler table\n\r");
   result = XScuGic_Connect(&ScuGic,XPAR_FABRIC_GCD_0_INTERRUPT_INTR,(Xil_InterruptHandler)gcd_isr,&GcdIpInstance);
   if(result != XST_SUCCESS){
      return result;
   }
   //print("Enable the Adder ISR\n\r");
   XScuGic_Enable(&ScuGic,XPAR_FABRIC_GCD_0_INTERRUPT_INTR);
   return XST_SUCCESS;
}

