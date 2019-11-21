#include <stdio.h>
#include <stdlib.h>

#include "mmult.h"

typedef float T;
int const DIM = 32;
int const SIZE = DIM*DIM;


void mmult_sw(T a[DIM][DIM], T b[DIM][DIM], T out[DIM][DIM])
{
	// matrix multiplication of a A*B matrix
	for (int ia = 0; ia < DIM; ++ia)
		for (int ib = 0; ib < DIM; ++ib)
		{

			float sum = 0;

			for (int id = 0; id < DIM; ++id)

				sum += a[ia][id] * b[id][ib];

			out[ia][ib] = sum;
		}
}


#ifdef DB_DEBUG

int main(void)
{

	int ret_val = 0;

	ret_val = test_matrix_mult<T, DIM, SIZE, 4,5,5>();

	return ret_val;

}

#else

int main(void)
{
	int i,j, err;

	T matOp1[DIM][DIM];
	T matOp2[DIM][DIM];
	T matMult_sw[DIM][DIM];
	T matMult_hw[DIM][DIM];

	AXI_VAL strDataIn[2*SIZE];
	AXI_VAL strDataOut[SIZE];

	/** Matrix Initiation */
	for(i = 0; i<DIM; i++)
	{
		for(j = 0; j<DIM; j++)
		{
			matOp1[i][j] = (float)(i+j);
			strDataIn[i*DIM+j] = push_stream<float,4,5,5>(matOp1[i][j], false);
		}
	}

	for(i = 0; i<DIM; i++)
	{
		for(j = 0; j<DIM; j++)
		{
			matOp2[i][j] = (float)(i*j);
			strDataIn[SIZE+i*DIM+j] = push_stream<float,4,5,5>(matOp2[i][j], false);
		}
	}
	/** End of Initiation */

	printf("NORMAL MODE\r\n");
	//standalone_mmult(matOp1, matOp2, matMult_hw);

	HLS_accel(strDataIn, strDataOut);

	for(int i=0; i<DIM; i++)
	{
		for(int j=0; j<DIM; j++)
		{
			int k = i*DIM+j;
			matMult_hw[i][j] = pop_stream<float,4,5,5>(strDataOut[k]);
		}
	}

	/* reference Matrix Multiplication */
	mmult_sw(matOp1, matOp2, matMult_sw);

	/** Matrix comparison */
	err = 0;
	for (i = 0; (i<DIM && !err); i++)
		for (j = 0; (j<DIM && !err); j++)
			if (matMult_sw[i][j] != matMult_hw[i][j])
				err++;

	if (err == 0)
		printf("Matrixes identical ... Test successful!\r\n");
	else
		printf("Test failed!\r\n");

	return err;

}



#endif
