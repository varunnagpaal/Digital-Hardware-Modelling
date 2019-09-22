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

// This function reorder the incoming stream (din) into bit-reversed address
// order then applies the algorithm to extract the spectral data for an
// FFT of N real points from data received from an N/2 complex FFT.  The
// first output location contains the 0th and N/2th bin values, which
// are strictly real; outputs 1 to (N-1) are complex.
template<typename TI, typename TO, int LOG2_REAL_SZ, bool BITREV>
void xfft2real(
      hls::stream<xfft_axis_t>& din,
      hls::stream<TO>& dout)
{
   enum {REAL_SZ = (1 << LOG2_REAL_SZ)};
   TI descramble_buf[REAL_SZ/2];
#pragma HLS ARRAY_PARTITION block factor=2 variable=descramble_buf
#pragma HLS INLINE // into a top-level DATAFLOW region

   // N-pt twiddle factor table used to descramble real from complex
   const complex<coeff_t> twid_rom[REAL_SZ/2] = {
#include "w_rom_1k_init.txt"
   };

realfft_be_buffer:
   for (int i = 0; i < REAL_SZ / 2; i++) {
#pragma HLS PIPELINE rewind
      xfft_axis_t tmp = din.read();
      ap_uint<LOG2_REAL_SZ-1> dst_addr = i;
      if (BITREV)
         dst_addr = dst_addr.range(0, LOG2_REAL_SZ - 2);
      descramble_buf[dst_addr] = tmp.data;
   }
realfft_be_descramble:
   for (int i = 0; i < REAL_SZ / 2; i++) {
#pragma HLS PIPELINE //rewind // Can't rewind b/c descramble_buf is ping-pong?
#if 0
      complex<TI> y1 = descramble_buf[i];
      complex<TO> cdata;
      if (i == 0) {
         cdata = complex<TO>(TO(y1.real() + y1.imag()), TO(y1.real() - y1.imag()));
      } else {
         complex<TI> y2 = conj(descramble_buf[(REAL_SZ / 2) - i]);
         // calculate: f = (y1 + y2) / 2; g = j*(y2 - y1) / 2
         complex<TI> f(TO( (y1.real() + y2.real()) / 2), TO((y1.imag() + y2.imag()) / 2));
         complex<TI> g(TO(-(y2.imag() - y1.imag()) / 2), TO( (y2.real() - y1.real()) / 2));
         complex<TO> wg = complex<TO>(twid_rom[i]) * complex<TO>(g);
         cdata = f + wg;
      }
      dout << cdata;
#else
      TI y1 = descramble_buf[i];
      TO cdata;
      if (i == 0) {
         cdata = TO((y1.real() + y1.imag()), (y1.real() - y1.imag()));
      } else {
         TI y2 = conj(descramble_buf[(REAL_SZ / 2) - i]);
         // calculate: f = (y1 + y2) / 2; g = j*(y2 - y1) / 2
         TI f(( (y1.real() + y2.real()) / 2), ((y1.imag() + y2.imag()) / 2));
         TI g((-(y2.imag() - y1.imag()) / 2), ( (y2.real() - y1.real()) / 2));
         TO wg = TO(twid_rom[i]) * TO(g);
         cdata = f + wg;
      }
      dout << cdata;
#endif
   }
}

#endif // XFFT2REAL_H_ not defined

