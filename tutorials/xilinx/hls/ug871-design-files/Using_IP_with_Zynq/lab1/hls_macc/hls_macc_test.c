#include <stdio.h>
#include <stdlib.h>
#include "hls_macc.h"

// Internal function prototypes
int ref_macc(int a, int b, int *c, bool clr_accum);

// Program entry for C test bench which is used to validate HLS DUT
//  functionality and automatically reused by Vivado HLS cosim_design
//  for RTL verification
int main(void)
{
   const int num_tests = 32;
   const int max_accum_len = 256;
   int a, b;
   int accum_hw, accum_sw;
   int i, j;
   int err_cnt = 0;

   for (i = 0; i < num_tests; i++) {
      int accum_len = rand() % max_accum_len + 1;
      for (j = 0; j < accum_len; j++) {
         // Clear the accumulators at beginning of each test run
         bool clr = j == 0 ? true : false;
         // Generate random test data, limit dynamic range to 12-bit
         a = (rand() - RAND_MAX / 2) >> (8*sizeof(int) - 12);
         b = (rand() - RAND_MAX / 2) >> (8*sizeof(int) - 12);
         hls_macc(a, b, &accum_hw, clr);
         ref_macc(a, b, &accum_sw, clr);
      }
      // Check HW result vs reference result
      if (accum_hw != accum_sw) {
         printf("!!! ERROR mismatch on test #%d - ", i);
         printf("HW returned: %d; ", accum_hw);
         printf("Expected: %d !!!\n", accum_sw);
         err_cnt++;
      }
   }
   if (err_cnt)
      printf("\n!!! %d TESTS FAILED !!!\n\n", err_cnt);
   else
      printf("\n*** %d Tests Passed ***\n\n", num_tests);
   // Always return 0 on success
   return err_cnt;
}

// Definition of reference software model of DUT
int ref_macc(int a, int b, int *accum, bool accum_clr)
{
   static acc_reg = 0;
   if (accum_clr)
      acc_reg = 0;
   acc_reg += a * b;
   *accum = acc_reg;
}

