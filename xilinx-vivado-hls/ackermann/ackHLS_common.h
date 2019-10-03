#ifndef HLS_COMMON_H
#define HLS_COMMON_H

#define VS
#undef VS

#ifdef VS
#include <stdint.h>
#define X_T uint8_t
#define Y_T uint32_t

#ifndef __cplusplus
typedef unsigned char bool;
static const bool False = 0;
static const bool True = 1;
#endif

#define BOOL_T bool
#define OUT_T uint64_t

#else
#include "ap_cint.h"
#define X_T uint3
#define Y_T uint6
#define BOOL_T uint1
#define OUT_T uint33
#endif

#define N 9

BOOL_T ackHLS(X_T x, Y_T y, OUT_T *pVal);

#endif // !HLS_COMMON_H
