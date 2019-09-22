#include "duc.h"

void srrc (
  srrc_data_t	*y,
  srrc_data_t	x
  ) {
  const srrc_coef_t c[48]={
#include "srrc_coef.h"
    };
  static srrc_acc_t shift_reg_p[48][2];
  static srrc_data_t in = 0;
  static uint1 init = 1;
  static uint1 ch = 0;
  static uint6 i = 0;

  srrc_acc_t acc;

  L1:
  // Latch input
  if (i==0) in = x;
  uint6 inc = i+1;
  // Calculate tap
  acc = srrc_mac(c[i], in, (init || i==23 || i==47) ? 0 : shift_reg_p[inc][ch]);
  // Shift
  shift_reg_p[i][ch] = acc;
  if (i==47) {
    if (ch) init = 0;
    ch = !ch;
  }

  // Output
  if (i==0 || i==24) {
    *y = acc >> 17;
  }
  i = (i==47) ? 0 : inc;
}
