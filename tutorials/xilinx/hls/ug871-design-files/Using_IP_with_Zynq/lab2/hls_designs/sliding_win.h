/*******************************************************************************
Vendor: Xilinx
Associated Filename: sliding_win.h
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

#ifndef SLIDING_WIN_H_
#define SLIDING_WIN_H_

#include <hls_stream.h>
#include <ap_int.h>
#include <ap_shift_reg.h>

// This function outputs a window of data that is half previously received
// plus half new incoming samples
template<typename T, int LEN>
void sliding_win_1in2out(
      hls::stream<T>& din,
      T *dout)
{
   enum {DELAY_LEN = LEN / 2}; // windows overlap by 1/2
   enum {DELAY_FIFO_DEPTH = DELAY_LEN / 2};

   T din_val;
   static ap_shift_reg<T, DELAY_LEN> delay_line;
   T nodelay[LEN/2], delayed[LEN/2];
#pragma HLS ARRAY_PARTITION variable=nodelay,delayed cyclic factor=2
#pragma HLS STREAM depth=DELAY_LEN variable=nodelay
#pragma HLS STREAM depth=DELAY_FIFO_DEPTH variable=delayed
#pragma HLS INLINE
#pragma HLS DATAFLOW

   // generate delayed and non-delayed streams of packed even-odd pairs
sliding_win_delay:
   for (int i = 0; i < LEN / 2; i++) {
#pragma HLS pipeline rewind
      din_val = din.read();
      nodelay[i] = din_val;
      delayed[i] = delay_line.shift(din_val);
   }
   // Mux delayed and non-delayed streams to dout (array) streams
sliding_win_output:
   for (int i = 0; i < LEN; i++) {
#pragma HLS UNROLL factor=2 // want to output two adj samples at a time
#pragma HLS pipeline rewind
      T dout_val;
      if (i < LEN / 2) {
         dout_val = delayed[i];
      } else {
         dout_val = nodelay[i % (LEN / 2)];
      }
      dout[i] = dout_val;
   }
}

#endif // SLIDING_WIN_H_ not defined
