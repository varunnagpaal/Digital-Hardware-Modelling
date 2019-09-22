#include "duc.h"

int main () {
  const int    SAMPLES=33;
  FILE         *fpi, *fpq;

  srrc_data_t xi,xq;
  imf3_data_t yi,yq;

  fpi=fopen("duc_i.dat","w");
  fpq=fopen("duc_q.dat","w");
  int i,j;
  mix_data_t   i_o[32];
  mix_data_t   q_o[32];
  mix_data_t   tmp_i_o[1];
  mix_data_t   tmp_q_o[1];

  xi = 0; xq = 0;
  for (j = 0; j < 96; j++) {
    if (j < 48) {
      duc(xi, FREQ, tmp_i_o, tmp_q_o);
    } else {
      duc(xq, FREQ, tmp_i_o, tmp_q_o);
    }
  }

  for (i=0;i<=SAMPLES;i++) {
    if (i==0) {
      xi=1<<17;
    } else {
      xi=0;
    };

    xq=-xi;

    int tmp = -1;
    for (j = 0; j < 96; j++) {
      if (j>=48 && ((j%6) < 2)) tmp++;
      if (j < 48) {
        duc(xi, FREQ, tmp_i_o, tmp_q_o);
      } else {
        duc(xq, FREQ, tmp_i_o, tmp_q_o);
      }
      if (j>=48 && ((j%6) < 2)) {
        i_o[tmp] = tmp_i_o[0];
        q_o[tmp] = tmp_q_o[0];
      }
    }

    for (j=0;j<16;j++) {
        yi = i_o[j];
        fprintf(fpi,"%i %d %d\n",i,xi>>17,yi);
        yq = q_o[j];
        fprintf(fpq,"%i %d %d\n",i,xq>>17,yq);
    }
  }
  fclose(fpi);
  fclose(fpq);

  /* Check the result */
  int ret1 = system("diff --brief -w duc_i.dat golden/duc_i.dat");
  int ret2 = system("diff --brief -w duc_q.dat golden/duc_q.dat");

  if (ret1 | ret2) {
      printf("\n *** DUC hardware test FAILED ! *** \n\n");
  } else {
      printf("\n *** DUC hardware test PASSED ! *** \n\n");
  }

  return ((ret1 | ret2) ? 1 : 0);
//return 1;
}
