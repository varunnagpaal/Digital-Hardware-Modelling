#include "duc.h"

void imf3 (
  imf3_data_t	*y,
  imf3_data_t	x
  ) {
  const imf3_coef_t c[6][2]={
#include "imf3_coef.h"
    };
/*
Transposed form FIR poly branches
*/
  static imf3_acc_t	shift_reg_p0[6][2];
  static imf3_acc_t	shift_reg_p1[6][2];
  static imf3_data_t in = 0;
  imf3_acc_t	acc0;
  imf3_acc_t	acc1;
  static uint1 init = 1;
  static uint6	i = 0;
  static uint6	j = 0;

  bool ch;
  L1:
  //Latch input
  if (i==0) {
    in = x;
  }
  uint6 inc = i+1;

    ch= apint_get_bit(j,3);
    //Calculate tap
    acc0 = mac(c[i][0], in, (init || i==5) ? 0 : shift_reg_p0[inc][ch]);
    acc1 = mac(c[i][1], in, (init || i==5) ? 0 : shift_reg_p1[inc][ch]);
    //Shift
    shift_reg_p0[i][ch] = acc0;
    shift_reg_p1[i][ch] = acc1;
    //Output
    *y = (i==0) ? acc0 >> 17 : acc1 >> 17;
    if (i==5 && j==15)
      init = 0;  
    if (i==5)
      j = (j==15) ? 0 : j+1;

    i = (i==5) ? 0 : inc;  
}
