/*******************************************************************************
Vendor: Xilinx
Associated Filename: apint_arith_test.c
Purpose:Vivado HLS Coding Style example
Device: All
Revision History: May 30, 2008 - initial release

*******************************************************************************
Copyright (C) 2013 XILINX, Inc.

This file contains confidential and proprietary information of Xilinx, Inc. and
is protected under U.S. and international copyright and other intellectual
property laws.

DISCLAIMER
This disclaimer is not a license and does not grant any rights to the materials
distributed herewith. Except as otherwise provided in a valid license issued to
you by Xilinx, and to the maximum extent permitted by applicable law:
(1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS, AND XILINX
HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY,
INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, OR
FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx shall not be liable (whether
in contract or tort, including negligence, or under any other theory of
liability) for any loss or damage of any kind or nature related to, arising under
or in connection with these materials, including for any direct, or any indirect,
special, incidental, or consequential loss or damage (including loss of data,
profits, goodwill, or any type of loss or damage suffered as a result of any
action brought by a third party) even if such damage or loss was reasonably
foreseeable or Xilinx had been advised of the possibility of the same.

CRITICAL APPLICATIONS
Xilinx products are not designed or intended to be fail-safe, or for use in any
application requiring fail-safe performance, such as life-support or safety
devices or systems, Class III medical devices, nuclear facilities, applications
related to the deployment of airbags, or any other applications that could lead
to death, personal injury, or severe property or environmental damage
(individually and collectively, "Critical Applications"). Customer asresultes the
sole risk and liability of any use of Xilinx products in Critical Applications,
subject only to applicable laws and regulations governing limitations on product
liability.

THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT
ALL TIMES.

*******************************************************************************/

#ifndef REFERENCE_FFT_H_
#define REFERENCE_FFT_H_

#include <stdint.h>
#include <complex>

// Reorder a vector with bit-reversed addressing
template<typename T>
void rad2_bitrev_sort(T *v_out, T *v_in, const uint32_t n_pts)
{
   uint32_t ix = 0;
   uint32_t ju = 0U;
   uint32_t iy = 0;
   for (uint32_t i = 0; i < n_pts - 1; i++) {
      v_out[iy] = v_in[ix];
      uint32_t n = n_pts;
      bool tst = true;
      while (tst) {
         n >>= 1;
         ju ^= n;
         tst = ((int32_t)(ju & n) == 0);
      }
      iy = ju;
      ix++;
   }
   v_out[iy] = v_in[ix];
}

// Generate a table of twiddle factors for a given FFT size
template<typename T>
void gen_twiddles(std::complex<T> *w, uint32_t n_pts)
{
   // Generate twiddle factors in natural order -- not performance optimized
   const double two_pi_over_pts = 2.0 * M_PI / n_pts;
   for (int i = 0; i < n_pts / 2; i++) {
      double re =  cos(two_pi_over_pts * (double)i);
      double im = -sin(two_pi_over_pts * (double)i);
      w[i] = std::complex<T>(T(re), T(im));
   }
}

// This is a reference fixed point FFT implementation which expects normalized
// data with an integer width of 1 (IW=1 for ap_fixed<>) i.e. with only a
// sign bit to the left of the fractional bits; range [-1.0, 1.0)
template<int IOW, int TW>
void fft_rad2_dit_nr(
      std::complex<ap_fixed<IOW, 1> > *y_out,
      std::complex<ap_fixed<IOW, 1> > *x_in,
      const uint32_t n_pts, bool ifft)
{
   std::complex<ap_fixed<TW, 1, AP_TRN, AP_SAT> > * const wtmp =
         new std::complex<ap_fixed<TW, 1, AP_TRN, AP_SAT> > [n_pts / 2];
   gen_twiddles<ap_fixed<TW, 1, AP_TRN, AP_SAT> >(wtmp, n_pts);
   std::complex<ap_fixed<TW, 1, AP_TRN, AP_SAT> > * const w =
         new std::complex<ap_fixed<TW, 1, AP_TRN, AP_SAT> > [n_pts / 2];
   rad2_bitrev_sort<std::complex<ap_fixed<TW, 1, AP_TRN, AP_SAT> > >(w,
         wtmp, n_pts / 2);
   delete [] wtmp;

   uint32_t groups = 1;
   uint32_t dist = n_pts / 2;
   while (groups < n_pts) {
      for (uint32_t k = 0; k < groups; k++) {
         std::complex<ap_fixed<TW, 1> > wk = w[k];
         if (ifft)
            wk.imag(-w[k].imag());
         for(uint32_t j = 2 * k * dist; j < (2 * k + 1) * dist; j++) {
            // The DIT butterfly
            std::complex<ap_fixed<IOW, 1> > y_r = groups == 1 ?
                  x_in[j] : y_out[j];
            std::complex<ap_fixed<IOW, 1> > z_r = groups == 1 ?
                  x_in[j + dist] : y_out[j + dist];
            ap_fixed<IOW + 1, 2> a = wk.real() * z_r.real() -
                  wk.imag() * z_r.imag();
            ap_fixed<IOW + 1, 2> b = wk.real() * z_r.imag() +
                  wk.imag() * z_r.real();
            y_out[j + dist].real((y_r.real() - a) / 2);
            y_out[j + dist].imag((y_r.imag() - b) / 2);
            y_out[j].real((y_r.real() + a) / 2);
            y_out[j].imag((y_r.imag() + b) / 2);
         }
      }
      groups *= 2;
      dist /= 2;
   }
   delete [] w;
}

#endif //ifndef REFERENCE_FFT_H_
