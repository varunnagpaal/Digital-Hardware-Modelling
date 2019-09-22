/*******************************************************************************
Vendor: Xilinx 
Associated Filename: hamming_window_test.c
Purpose: Vivado HLS tutorial example 
Revision History: March 1, 2013 - initial release
                                                
*******************************************************************************
Copyright (C) 2013 XILINX, Inc. 

This file contains confidential and proprietary information of Xilinx, Inc. and 
is protected under U.S. and international copyright and other intellectual 
property laws.

DISCLAIMER
This disclaimer is not a license and does not grant any rights to the materials 
distributed herewith. Except as otherwise provided in a valid license issued to 
you by Xilinx, and to the maximum extent permitted by applicable law: 
(1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS, AND XILINX 
HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, 
INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, OR 
FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx shall not be liable (whether 
in contract or tort, including negligence, or under any other theory of 
liability) for any loss or damage of any kind or nature related to, arising under 
or in connection with these materials, including for any direct, or any indirect, 
special, incidental, or consequential loss or damage (including loss of data, 
profits, goodwill, or any type of loss or damage suffered as a result of any 
action brought by a third party) even if such damage or loss was reasonably 
foreseeable or Xilinx had been advised of the possibility of the same.

CRITICAL APPLICATIONS
Xilinx products are not designed or intended to be fail-safe, or for use in any 
application requiring fail-safe performance, such as life-support or safety 
devices or systems, Class III medical devices, nuclear facilities, applications 
related to the deployment of airbags, or any other applications that could lead 
to death, personal injury, or severe property or environmental damage 
(individually and collectively, "Critical Applications"). Customer assumes the 
sole risk and liability of any use of Xilinx products in Critical Applications, 
subject only to applicable laws and regulations governing limitations on product 
liability. 

THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT 
ALL TIMES.

*******************************************************************************/
#include <stdio.h>

#include "hamming_window.h"

int main(int argc, char *argv[])
{
   in_data_t test_data[WINDOW_LEN];
   out_data_t hw_result[WINDOW_LEN], sw_result[WINDOW_LEN];
   int i;
   unsigned err_cnt = 0, check_dots = 0;
   FILE        *fp;

   for (i = 0; i < WINDOW_LEN; i++) {
      // Generate a test pattern for input to DUT
      test_data[i] = (in_data_t)((32767.0 * (double)((i % 16) - 8) / 8.0) + 0.5);
      // Calculate the coefficient value for this index
      in_data_t coeff_val = (in_data_t)(WIN_COEFF_SCALE * (0.54 -
         0.46 * cos(2.0 * M_PI * i / (double)(WINDOW_LEN - 1))));
      // Generate array of expected values -- n.b. explicit casts to avoid
      // integer promotion issues
      sw_result[i] = (out_data_t)test_data[i] * (out_data_t)coeff_val;
   }

   // Call the DUT
   printf("Running DUT...");
   hamming_window(hw_result, test_data);
   printf("done.\n");

   // Check the results returned by DUT against expected values
   fp=fopen("result.dat","w");
   printf("Testing DUT results");
   for (i = 0; i < WINDOW_LEN; i++) {
	  fprintf(fp, "%d %d \n", hw_result[i],sw_result[i]);
      if (hw_result[i] != sw_result[i]) {
         err_cnt++;
         check_dots = 0;
         printf("\n!!! ERROR at i = %4d - expected: %10d\tgot: %10d",
               i, sw_result[i], hw_result[i]);
      } else { // indicate progress on console
         if (check_dots == 0)
            printf("\n");
         printf(".");
         if (++check_dots == 64)
            check_dots = 0;
      }
   }
   fclose(fp);
   printf("\n");

   // Print final status message
   if (err_cnt) {
      printf("!!! TEST FAILED - %d errors detected !!!\n", err_cnt);
   } else
      printf("*** Test Passed ***\n");

   // Only return 0 on success
   return err_cnt;
}

