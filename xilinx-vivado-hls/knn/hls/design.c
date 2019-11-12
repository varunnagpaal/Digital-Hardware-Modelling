#include "design_common.h"

void hls_func(uint16 volatile const *pSrcBuffer,
			  uint16 volatile *pDestBuffer
			  )
{
	// if I remove offset from m_axi, RTL ports for buffer pointers of I/O protocol type "ap_none" are not created
	// s_axilite on return is required iff offset=slave option is selected
#pragma HLS INTERFACE s_axilite port=return bundle=s_axi_lite_gp0_hls
#pragma HLS INTERFACE m_axi depth=9 port=pDestBuffer offset=slave bundle=m_axi_hp0_hls
#pragma HLS INTERFACE m_axi depth=9 port=pSrcBuffer offset=slave bundle=m_axi_hp0_hls

	add_loop_1:for(int i=0; i < 9; ++i)
	{
#pragma HLS UNROLL factor=9
		pDestBuffer[i] = pSrcBuffer[i]+1;
	}
}
