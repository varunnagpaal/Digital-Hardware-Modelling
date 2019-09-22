#include "duc.h"

void dds (
    acc_t	freq,
    dds_t	*sine,
    dds_t	*cosine
  ) {
  static acc_t	acc;
  const dds_t dds_table[1<<P] = {
#include "dds_table.h"
  };
  phi_t		phase1, phase2;

  acc		+= freq;
#if defined(DITHER)
  phase1	= (acc+rnd()) >> B;
#elif defined(NOISE_SHAPE)
  static rnd_t	noise;
  acc_t		Lphase;
  Lphase	= acc +	noise;
  phase1	= Lphase >> B;
  noise		= apint_get_range(Lphase,B-1,0);
#else
  phase1	= acc >> B;
#endif
  *sine		= dds_table[phase1];
/*
cos=sin(PI/2-phase)
2*PI ~ 1<<P
PI/2 ~ 1<<P>>2
*/
  phase2	= (1<<(P-2)) - phase1;
  *cosine	= dds_table[phase2];
}
