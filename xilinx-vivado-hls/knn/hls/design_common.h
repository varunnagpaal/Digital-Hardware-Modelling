#ifndef DESIGN_COMMON_H
#define DESIGN_COMMON_H
#include <ap_cint.h>
void hls_func(uint16 volatile const *pSrcBuffer,
			  uint16 volatile *pDestBuffer
			  );

void expected(uint16 const *pSrcBuffer,
			  uint16 *pDestBuffer
			  );
#endif	// !DESIGN_COMMON_H
