/*******************************************************************************
Vendor: Xilinx
Associated Filename: hls_realfft.h
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

#ifndef HLS_REALFFT_H_
#define HLS_REALFFT_H_

#include <complex>
#include <ap_fixed.h>
#include "window_fn.h"

//#define USE_FLOAT
using namespace std;

#define DIN_W 16
#define DOUT_W DIN_W
typedef ap_fixed<DIN_W, 1> din_t;
//typedef ap_fixed<DOUT_W, 1> dout_t;
typedef complex<ap_fixed<DOUT_W, 1> > dout_t;
typedef ap_fixed<DIN_W, 1, AP_TRN, AP_SAT> coeff_t; // MUST have IW >= 1

#define REAL_FFT_LEN      1024
#define LOG2_REAL_FFT_LEN 10

//#define WIN_LEN REAL_FFT_LEN
#define WIN_FN_TYPE HAMMING

#define XDMA_WORD_W (2 * DIN_W)
#define XDMA_BURST_LEN 256

typedef struct {
   ap_uint<XDMA_WORD_W> data;
   ap_uint<XDMA_WORD_W/8> keep;
   ap_uint<1> last;
} xdma_axis_t;

typedef struct {
   //complex<dout_t> data;
   dout_t data;
   ap_uint<1> last;
} xfft_axis_t;

// Front-end top-level function prototype for synthesis
void hls_real2xfft(
      hls::stream<din_t>& din,
      hls::stream<xfft_axis_t>& dout);
// Backend top-level function prototype for synthesis
void hls_xfft2real(
      hls::stream<xfft_axis_t>& din,
      hls::stream<dout_t>& dout);


#endif // HLS_REALFFT_H_ not defined
