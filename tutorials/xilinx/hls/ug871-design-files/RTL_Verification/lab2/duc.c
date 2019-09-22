#include "duc.h"

void duc (
  srrc_data_t	din_i,
  acc_t         freq,
  mix_data_t	*dout_i,
  mix_data_t	*dout_q
  ) {
  
  srrc_data_t	srrc_o;
  imf1_data_t	imf1_o;
  imf2_data_t	imf2_o;
  imf3_data_t	imf3_o;

/*
Execute 32 times for full processing
0 xxxx
1 xxxx
| ||||_imf3           v v v v v v v v v v v v v v v v
| |||__imf2           v 0 v 0 v 0 v 0 v 0 v 0 v 0 v 0
| ||___imf1           v 0 0 0 v 0 0 0 v 0 0 0 v 0 0 0
| |____srrc           v 0 0 0 0 0 0 0 v 0 0 0 0 0 0 0
|______channel (I/Q)  v 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
|______din (I/Q)      v 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
*/
  
  //Process both channels

  srrc(&srrc_o, din_i);

  imf1(&imf1_o, srrc_o);

  imf2(&imf2_o, imf1_o);

  imf3(&imf3_o, imf2_o);

  mixer(freq, imf3_o, dout_i, dout_q);

}
