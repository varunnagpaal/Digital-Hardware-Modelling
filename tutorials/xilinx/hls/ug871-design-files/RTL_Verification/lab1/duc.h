#ifndef _DDS_H_
#define _DDS_H_
#include "ap_cint.h"
#include <stdio.h>
#include <stdlib.h>

#define	N	16
#define	P	5
#define M	16
#define B	11
#define FREQ	6628
//#define FREQ	1657
//#define FREQ	0
/*
N	Accumulator
P	Phase
M	Output
B	N-P
Frequency
=========
Fomin	= (Fs/(2^N))
Fo	= (Fs/(2^N))*Dacc
Fomax	= (Fs/2^(N-P))

Phase Quantization
==================
SFDRest	= 6.02P - 3.92dB
P 	= (SFDR+3.92)/6.02

Amplitude Quantization
======================
SNRest	= -6.02M -1.76db
Best performance (-SFDR<SNR): P = M+1
*/
#define	int(x)		int_(x)
#define int_(x)		int ## x
#define uint(x)		uint_(x)
#define uint_(x)	uint ## x

typedef uint(N)		acc_t;
typedef uint(P)		phi_t;
typedef int(M)		dds_t;
typedef uint(B)		rnd_t;

#define srrc_N		45
// Largest coefficient:	69475 (0x10F63)
typedef int18		srrc_data_t;
typedef int18		srrc_coef_t;
typedef int38		srrc_acc_t;

#define imf1_N		23
typedef int18		imf1_data_t;
typedef int18		imf1_coef_t;
typedef int38		imf1_acc_t;

#define imf2_N		11
typedef int18		imf2_data_t;
typedef int18		imf2_coef_t;
typedef int38		imf2_acc_t;

#define imf3_N		11
typedef int18		imf3_data_t;
typedef int18		imf3_coef_t;
typedef int38		imf3_acc_t;

typedef	int18		mix_data_t;

void duc (
  srrc_data_t	din_i,
  acc_t       freq,
  mix_data_t	*dout_i,
  mix_data_t	*dout_q
  );

int37 mult (
  int18	c,
  int19	d
  );

int37 symtap (
  int18 a,
  int18 b,
  int18 c
  );

srrc_acc_t srrc_mac (
  int18	c,
  int18	d,
  int40	s
  );

imf1_acc_t mac1 (
  imf1_coef_t c,
  imf1_data_t d,
  imf1_acc_t s
  );

imf2_acc_t mac2 (
  imf2_coef_t c,
  imf2_data_t d,
  imf2_acc_t s
  );

int48 mac (
  int18	c,
  int18	d,
  int48	s
  );

void srrc (
  srrc_data_t	*y,
  srrc_data_t	x
  );

void imf1 (
  imf1_data_t	*y,
  imf1_data_t	x
  );

void imf2 (
  imf2_data_t	*y,
  imf2_data_t	x
  );

void imf3 (
  imf2_data_t	*y,
  imf2_data_t	x
  );

void mixer (
  acc_t        freq,
  mix_data_t   Din,
  mix_data_t   *Dout_I,
  mix_data_t   *Dout_Q
  );

void dds (
  acc_t		freq,
  dds_t		*sin,
  dds_t		*cosine
  );

rnd_t rnd();

#endif
