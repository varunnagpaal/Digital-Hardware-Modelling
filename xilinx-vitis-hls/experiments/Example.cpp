#include "memory.h"
#include "ap_int.h"
#define UNROLL_FACTOR 40
#define	DATA_SZ		  (UNROLL_FACTOR*100)

const int unroll_factor = UNROLL_FACTOR;

void task(volatile ap_uint<16> *stream, ap_uint<16> (&buff)[DATA_SZ])
{
#pragma HLS ARRAY_PARTITION variable=buff cyclic factor=unroll_factor dim=1
	memcpy(buff,(const ap_uint<16>*)stream,DATA_SZ*sizeof(ap_uint<16>));

	stream_process_loop:
	for(int i=0; i < DATA_SZ; i++){
		#pragma HLS PIPELINE
		#pragma HLS UNROLL factor=unroll_factor
		buff[i] = buff[i] * 100;
	}

	memcpy((ap_uint<16> *)stream,buff,DATA_SZ*sizeof(ap_uint<16>));
}

void example(volatile ap_uint<16> *streamA, volatile ap_uint<16> *streamB)
{
#pragma HLS DATAFLOW
#pragma HLS INTERFACE m_axi depth=unroll_factor port=streamA bundle=hp0 offset=slave
#pragma HLS INTERFACE m_axi depth=unroll_factor port=streamB bundle=hp2 offset=slave
#pragma HLS INTERFACE s_axilite port=return

ap_uint<16> buffA[DATA_SZ];
ap_uint<16> buffB[DATA_SZ];

	task( streamA, buffA);
	task( streamB, buffB);
}
