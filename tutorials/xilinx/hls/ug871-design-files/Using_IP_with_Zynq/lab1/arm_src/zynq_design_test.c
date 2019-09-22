#include <stdio.h>
#include "platform.h"
// Add BSP header files
#include <stdlib.h>  // Standard C functions, e.g. exit()
#include <stdbool.h> // Provides a Boolean data type for ANSI/ISO-C
#include "xparameters.h" // Parameter definitions for processor periperals
#include "xscugic.h"     // Processor interrupt controller device driver
#include "XHls_macc.h"   // Device driver for HLS HW block

// HLS macc HW instance
XHls_macc HlsMacc;
//Interrupt Controller Instance
XScuGic ScuGic;
// Global variable definitions - used by ISR
volatile static int RunHlsMacc = 0;
volatile static int ResultAvailHlsMacc = 0;

// Setup and helper functions
int setup_interrupt();
int hls_macc_init(XHls_macc *hls_maccPtr);
void hls_macc_start(void *InstancePtr);
// The ISR prototype
void hls_macc_isr(void *InstancePtr);
// Software model of HLS hardware
void sw_macc(int a, int b, int *accum, bool accum_clr);

int main()
{
   print("Program to test communication with HLS MACC block in PL\n\r");
   int a = 2, b = 21;
   int res_hw;
   int res_sw;
   int i;
   int status;

   //Setup the matrix mult
   status = hls_macc_init(&HlsMacc);
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
   XHls_macc_SetA(&HlsMacc, a);
   XHls_macc_SetB(&HlsMacc, b);
   XHls_macc_SetAccum_clr(&HlsMacc, 1);

   if (XHls_macc_IsReady(&HlsMacc))
      print("HLS peripheral is ready.  Starting... ");
   else {
      print("!!! HLS peripheral is not ready! Exiting...\n\r");
      exit(-1);
   }

   if (0) { // use interrupt
      hls_macc_start(&HlsMacc);
      while(!ResultAvailHlsMacc)
         ; // spin
      res_hw = XHls_macc_GetAccum(&HlsMacc);
      print("Interrupt received from HLS HW.\n\r");
   } else { // Simple non-interrupt driven test
      XHls_macc_Start(&HlsMacc);
      do {
         res_hw = XHls_macc_GetAccum(&HlsMacc);
      } while (!XHls_macc_IsReady(&HlsMacc));
      print("Detected HLS peripheral complete. Result received.\n\r");
   }

   //call the software version of the function
   sw_macc(a, b, &res_sw, false);

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

void sw_macc(int a, int b, int *accum, bool accum_clr)
{
   static int accum_reg = 0;
   if (accum_clr)
      accum_reg = 0;
   accum_reg += a * b;
   *accum = accum_reg;
}

int hls_macc_init(XHls_macc *hls_maccPtr)
{
   XHls_macc_Config *cfgPtr;
   int status;

   cfgPtr = XHls_macc_LookupConfig(XPAR_XHLS_MACC_0_DEVICE_ID);
   if (!cfgPtr) {
      print("ERROR: Lookup of acclerator configuration failed.\n\r");
      return XST_FAILURE;
   }
   status = XHls_macc_CfgInitialize(hls_maccPtr, cfgPtr);
   if (status != XST_SUCCESS) {
      print("ERROR: Could not initialize accelerator.\n\r");
      return XST_FAILURE;
   }
   return status;
}

void hls_macc_start(void *InstancePtr){
   XHls_macc *pAccelerator = (XHls_macc *)InstancePtr;
   XHls_macc_InterruptEnable(pAccelerator,1);
   XHls_macc_InterruptGlobalEnable(pAccelerator);
   XHls_macc_Start(pAccelerator);
}

void hls_macc_isr(void *InstancePtr){
   XHls_macc *pAccelerator = (XHls_macc *)InstancePtr;

   //Disable the global interrupt
   XHls_macc_InterruptGlobalDisable(pAccelerator);
   //Disable the local interrupt
   XHls_macc_InterruptDisable(pAccelerator,0xffffffff);

   // clear the local interrupt
   XHls_macc_InterruptClear(pAccelerator,1);

   ResultAvailHlsMacc = 1;
   // restart the core if it should run again
   if(RunHlsMacc){
      hls_macc_start(pAccelerator);
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
   result = XScuGic_Connect(&ScuGic,XPAR_FABRIC_HLS_MACC_0_INTERRUPT_INTR,(Xil_InterruptHandler)hls_macc_isr,&HlsMacc);
   if(result != XST_SUCCESS){
      return result;
   }
   //print("Enable the Adder ISR\n\r");
   XScuGic_Enable(&ScuGic,XPAR_FABRIC_HLS_MACC_0_INTERRUPT_INTR);
   return XST_SUCCESS;
}

