#include "design_common.h"

void hls_func(int16 volatile const *pSrcBuffer,
			  int16 volatile *pDestBuffer
			  )
{
	// if I remove offset from m_axi, RTL ports for buffer pointers of I/O protocol type "ap_none" are not created
	// s_axilite on return is required iff offset=slave option is selected
#pragma HLS INTERFACE s_axilite port=return bundle=s_axi_lite_gp0_hls
#pragma HLS INTERFACE m_axi depth=65536 port=pDestBuffer offset=slave bundle=m_axi_hp0_hls
#pragma HLS INTERFACE m_axi depth=65536 port=pSrcBuffer offset=slave bundle=m_axi_hp0_hls

	int16 srcBuffer[65536];
	int16 destBuffer[9];
	for(int d=0; d < 9; ++d)
	{
		for( int s=0; s < 65536; ++s)
		{
			pDestBuffer[d] += pSrcBuffer[s];
		}
	}
}
