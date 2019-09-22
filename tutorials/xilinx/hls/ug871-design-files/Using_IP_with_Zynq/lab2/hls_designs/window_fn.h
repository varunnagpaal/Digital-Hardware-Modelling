#ifndef WINDOW_FN_H_
#define WINDOW_FN_H_

#include <cmath>
#include <hls_stream.h>
using namespace std;

namespace hls_window_fn {

typedef enum {
   RECT = 0, HANN, HAMMING, GAUSSIAN
} win_fn_t;

// Helper functions
template<int SZ, win_fn_t FT>
double coef_calc(int idx)
{
   double coef_val;

   switch(FT) {
   case RECT:
      coef_val = 1.0;
      break;
   case HANN:
      coef_val = 0.5 * (1.0 - cos(2.0 * M_PI * idx / double(SZ)));
      break;
   case HAMMING:
      coef_val = 0.54 - 0.46 * cos(2.0 * M_PI * idx / double(SZ));
      break;
   case GAUSSIAN:
      const double gaussian_sigma = 0.5;
      double x = (idx - SZ / 2) / (gaussian_sigma * (SZ / 2));
      coef_val = exp(-0.5 * x * x);
      break;
   }
   return coef_val;
}

template<class TC, int SZ, win_fn_t FT>
void init_coef_tab(TC *coeff)
{
   for (int i = 0; i < SZ; i++) {
      coeff[i] = coef_calc<SZ,FT>(i);
   }
};

template<class TI, class TO, class TC, int SZ, win_fn_t FT, int UF>
void window_fn(TI *indata, TO *outdata)
{
   TC coeff_tab[SZ];
   init_coef_tab<TC,SZ,FT>(coeff_tab);
#pragma HLS ARRAY_PARTITION variable=coeff_tab cyclic factor=UF

apply_win_fn:
   for (unsigned i = 0; i < SZ; i++) {
#pragma HLS UNROLL factor=UF
#pragma HLS PIPELINE rewind
      outdata[i] = coeff_tab[i] * indata[i];
   }
}

}; // namespace hls_window_fn

#endif // WINDOW_FN_H_

