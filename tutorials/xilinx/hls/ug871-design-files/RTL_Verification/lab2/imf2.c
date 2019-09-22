#include "duc.h"

void imf2 (
  imf2_data_t	*y,
  imf2_data_t	x
  ) {
  const imf2_coef_t c[12]={
#include "imf2_coef.h"
    };
/*
Transposed form FIR poly branches
*/
  static imf2_acc_t	shift_reg_p[13][2];
  static imf2_data_t	in = 0;
  imf2_acc_t	acc;

  static uint1 init = 1;
  static uint2 cnt = 0;
  static uint1 ch = 0;
  static uint4 i = 0;
  
  L1:
  //Latch input
  if (i==0) {
    in = x;
  }
  uint4 inc = i+1;
  //Calculate tap
  acc = mac2(c[i], in, (init || i==5 || i==11) ? 0 : shift_reg_p[inc][ch]);
  //Shift
  shift_reg_p[i][ch] = acc;
  if (i==11) {
    if (cnt == 3) {
      if (ch) init = 0;  
      ch = !ch;
    }
    cnt++;
  }
  //Output
  if ((i==0) || (i==6))
  {
    *y = acc >> 17;
  }

  i = (i == 11) ? 0 : inc;
}
