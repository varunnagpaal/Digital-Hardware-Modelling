#include "duc.h"

void imf1 (
  imf1_data_t	*y,
  imf1_data_t	x
  ) {
  const imf1_coef_t c[24]={
#include "imf1_coef.h"
    };
/*
Transposed form FIR poly branches
*/
  static imf1_acc_t	shift_reg_p[25][2];
  static imf1_data_t in = 0;
  static uint1 init = 1;
  static uint1 cnt = 0;
  static uint1 ch = 0;
  static uint5 i = 0; 

  imf1_acc_t acc;
  
  L1:
  //Latch input
  if (i==0) {
    in = x;
  }
  uint5 inc = i+1;

  //Calculate tap
  acc = mac1(c[i], in, (init || i==11 || i==23) ? 0 : shift_reg_p[inc][ch]);
  //Shift
  shift_reg_p[i][ch] = acc;
  if (i==23) {
    if (ch) init = 0;
    ch = ch ^ cnt;
    cnt = !cnt;
  }
  //Output
  if ((i==0) || (i==12))
  {
    *y = acc >> 17;
  }

  i = (i == 23) ? 0 : inc;
}
