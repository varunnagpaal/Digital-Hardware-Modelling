#include "duc.h"

// Subtraction is absorbed into DSP
int37 mix_SubDSP(int18 a, int18 b, int18 c)
{
  //return ((int36)a-(int36)b) * (int36)c;
  int19 tmp = a - b;
  int37 m = mult(c, tmp);
  return m;
}

// Addition is absorbed into DSP
int36 mix_AddDSP(int18 a, int18 b, int18 c)
{
  //return ((int36)a+(int36)b) * (int36)c;
  int19 tmp = a + b;
  int37 m = mult(c, tmp);
  return m;
}

void mixer (
  acc_t        freq,
  mix_data_t   Din,
  mix_data_t   *Dout_I,
  mix_data_t   *Dout_Q
  ) {
  mix_data_t Din_re;
  static mix_data_t Din_im;
  dds_t cosine, sine;
  static mix_data_t DI_cache[16];
  static uint1 init = 1;

  static uint4 index = 0;
  static uint3 i = 0;
  static uint1 ch = 1;

  uint3 inc = i + 1;
  bool valid_in = (i<2);
  acc_t freq_dds = init ? 0 : freq;

  L1:

  Din_im = Din;

  if (ch && valid_in) {
    DI_cache[index] = Din_im;
  }
  else if (valid_in) {
    dds(freq_dds,&sine,&cosine);
    Din_re = DI_cache[index];
#if 0
    int34 tmp1 = mix_SubDSP(sine, cosine, Din_im);
    int34 tmp2 = mix_SubDSP(Din_re, Din_im, sine);
    int34 tmp3 = mix_AddDSP(Din_re, Din_im, cosine);
    *Dout_I = (tmp1 + tmp2)>>(M-2);
    *Dout_Q = (tmp1 + tmp3)>>(M-2);
#else
    int34 tmp = mix_SubDSP(sine, cosine, Din_im);
    *Dout_I = (tmp + mix_SubDSP(Din_re, Din_im, sine))>>(M-2);
    *Dout_Q = (tmp + mix_AddDSP(Din_re, Din_im, cosine))>>(M-2);
#endif
    if (index==15)
    {
      init = 0;
    }
  }

  if (index==15){ ch = !ch; }
  if (valid_in) index++;
  i = (i==5) ? 0 : inc;
}
