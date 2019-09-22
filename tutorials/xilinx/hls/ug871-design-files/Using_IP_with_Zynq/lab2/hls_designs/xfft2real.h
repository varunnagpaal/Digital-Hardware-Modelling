/*******************************************************************************
Vendor: Xilinx
Associated Filename: xfft2real.h
Purpose: Part of a Vivado HLS tutorial example
Device: All
Revision History: March 31, 2013 - initial release

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

#ifndef XFFT2REAL_H_
#define XFFT2REAL_H_

#include "hls_realfft.h"

// This function reorders the incoming stream (din) into bit-reversed address
// order then applies the algorithm to extract the spectral data for an
// FFT of N real points from data received from an N/2 complex FFT.  The
// first output location contains the 0th and N/2th bin values, which
// are strictly real; outputs 1 to (N-1) are complex.
template<typename TI, typename TO, int LOG2_REAL_SZ, bool BITREV>
void xfft2real(
      hls::stream<xfft_axis_t<TI> >& din,
      hls::stream<xfft_axis_t<TO> >& dout)
{
   enum {REAL_SZ = (1 << LOG2_REAL_SZ)};
   enum {REAL_HI_FIFO_DEPTH = REAL_SZ / 4};
   complex<TI> descramble_buf[REAL_SZ/2];
   hls::stream<complex<TO> > real_spectrum_lo("real_spectrum_lo");
   hls::stream<complex<TO> > real_spectrum_hi("real_spectrum_hi");
   complex<TO> real_spectrum_hi_buf[REAL_SZ / 4];
#pragma HLS STREAM variable=real_spectrum_lo depth=8
#pragma HLS STREAM variable=real_spectrum_hi depth=8
#pragma HLS ARRAY_PARTITION block factor=2 variable=descramble_buf
#pragma HLS INLINE // into a top-level DATAFLOW region

   // N-pt twiddle factor table used to descramble real from complex
   const complex<coeff_t> twid_rom[REAL_SZ/4] = {
#include "w_rom_1k_1quad_init.txt"
   };

realfft_be_buffer:
   for (int i = 0; i < REAL_SZ / 2; i++) {
#pragma HLS PIPELINE rewind
      xfft_axis_t<dout_t> tmp = din.read();
      ap_uint<LOG2_REAL_SZ-1> dst_addr = i;
      if (BITREV)
         dst_addr = dst_addr.range(0, LOG2_REAL_SZ - 2);
      descramble_buf[dst_addr] = tmp.data;
   }
realfft_be_descramble:
   for (int i = 0; i < REAL_SZ / 4; i++) {
#pragma HLS PIPELINE //no rewind b/c descramble_buf is ping-pong
      complex<TI> y1 = descramble_buf[i];
      complex<TO> w, cdata1, cdata2;
      if (i == 0) {
         cdata1 = complex<TO>(TO(y1.real() + y1.imag()),
               TO(y1.real() - y1.imag()));
         cdata2 = complex<TO>(descramble_buf[REAL_SZ / 4]);
      } else {
         complex<TI> y2 = conj(descramble_buf[(REAL_SZ / 2) - i]);
         // calculate: f = (y1 + y2) / 2; g = j*(y2 - y1) / 2
         complex<TI> f(TO( (y1.real() + y2.real()) / 2),
               TO((y1.imag() + y2.imag()) / 2));
         complex<TI> g(TO(-(y2.imag() - y1.imag()) / 2),
               TO( (y2.real() - y1.real()) / 2));
         if (i == REAL_SZ / 4)
            w = complex<TO>(complex<coeff_t>(0.0, -1.0));
         else
            w = complex<TO>(twid_rom[i]);
         complex<TO> wg = w * complex<TO>(g);
         cdata1 = f + wg;
         cdata2 = conj(f - wg);
      }
      real_spectrum_lo << complex<TO>(cdata1.real() / 2, cdata1.imag() / 2);
      real_spectrum_hi_buf[((REAL_SZ / 2) - i) % (REAL_SZ / 4)] =
         complex<TO>(cdata2.real() / 2, cdata2.imag() / 2);
   }
realfft_be_rev_real_hi:
   for (int i = 0; i < REAL_SZ / 4; i++) {
#pragma HLS PIPELINE //no rewind b/c real_spectrum_buf is ping-pong
         real_spectrum_hi << real_spectrum_hi_buf[i];
   }
realfft_be_stream_output:
   for (int i = 0; i < REAL_SZ / 2; i++) {
#pragma HLS PIPELINE rewind
      xfft_axis_t<dout_t> dout_val;
      if (i < REAL_SZ / 4)
         dout_val.data = real_spectrum_lo.read();
      else
         dout_val.data = real_spectrum_hi.read();
      dout_val.last = i == REAL_SZ / 2 - 1 ? 1 : 0;

      dout << dout_val;
   }
}

#endif // XFFT2REAL_H_ not defined

