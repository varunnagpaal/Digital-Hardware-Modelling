#include "memory.h"
#include "ap_int.h"
#define UNROLL_FACTOR 40
#define	DATA_SZ		  (UNROLL_FACTOR*100)

void example(volatile ap_uint<16> *streamA, volatile ap_uint<16> *streamB)
{
#pragma HLS DATAFLOW
	const int unroll_factor = UNROLL_FACTOR;

#pragma HLS INTERFACE m_axi depth=unroll_factor port=streamA bundle=hp0 offset=slave
#pragma HLS INTERFACE m_axi depth=unroll_factor port=streamB bundle=hp2 offset=slave
#pragma HLS INTERFACE s_axilite port=return

int i;
ap_uint<16> buffA[DATA_SZ];
#pragma HLS ARRAY_PARTITION variable=buffA cyclic factor=40 dim=1
ap_uint<16> buffB[DATA_SZ];
#pragma HLS ARRAY_PARTITION variable=buffB cyclic factor=40 dim=1

	{
		memcpy(buffA,(const ap_uint<16>*)streamA,DATA_SZ*sizeof(ap_uint<16>));

		stream1_process_loop:
		for(i=0; i < DATA_SZ; i++){
			#pragma HLS PIPELINE
			#pragma HLS UNROLL factor=unroll_factor
			buffA[i] = buffA[i] * 100;
		}

		memcpy((ap_uint<16> *)streamA,buffA,DATA_SZ*sizeof(ap_uint<16>));
	}

	{
		memcpy(buffB,(const ap_uint<16>*)streamB,DATA_SZ*sizeof(ap_uint<16>));

		stream2_process_loop:
		for(i=0; i < DATA_SZ; i++){
			#pragma HLS PIPELINE
			#pragma HLS UNROLL factor=unroll_factor
			buffB[i] = buffB[i] * 100;
		}

		memcpy((ap_uint<16> *)streamB,buffB,DATA_SZ*sizeof(ap_uint<16>));
	}
}
