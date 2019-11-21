#include <stdio.h>
#include <stdlib.h>

#include "mmult.h"

// THIS IS THE TOP LEVEL DESIGN THAT WILL BE SYNTHESIZED
#define MCR_SIZE 1024

void standalone_mmult (float A[32][32], float B[32][32], float C[32][32])
{
	mmult_hw <float, 32>(A, B, C);
}

//void HLS_accel (AXI_VAL in_stream[2*MCR_SIZE], AXI_VAL out_stream[MCR_SIZE])
void HLS_accel (AXI_VAL INPUT_STREAM[2*MCR_SIZE], AXI_VAL OUTPUT_STREAM[MCR_SIZE])
{
#pragma HLS INTERFACE s_axilite port=return     bundle=CONTROL_BUS
#pragma HLS INTERFACE axis      port=OUTPUT_STREAM
#pragma HLS INTERFACE axis      port=INPUT_STREAM

// HLS DEPRECATED MODE
//	// Map ports to Vivado HLS interfaces 
//	#pragma HLS INTERFACE ap_fifo port=in_stream
//	#pragma HLS INTERFACE ap_fifo port=out_stream
//	// Map HLS ports to AXI interfaces
//	#pragma HLS RESOURCE variable=in_stream  core=AXIS metadata="-bus_bundle INPUT_STREAM"
//	#pragma HLS RESOURCE variable=out_stream core=AXIS metadata="-bus_bundle OUTPUT_STREAM"
//	#pragma HLS RESOURCE variable=return core=AXI4LiteS metadata="-bus_bundle CONTROL_BUS"

	wrapped_mmult_hw <float, 32, 32*32, 4, 5, 5>(INPUT_STREAM, OUTPUT_STREAM);

	return;
}

