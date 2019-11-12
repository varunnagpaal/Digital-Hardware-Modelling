#include "design_common.h"
#include "datasets.h"

void expected(uint16 const *pSrcBuffer,
			  uint16 *pDestBuffer
			  )
{
	for(int i=0; i < 9; ++i)
	{
		pDestBuffer[i] = pSrcBuffer[i]+1;
	}
}

int main()
{
	int fail = 0;
	uint16 expResult[9];
	uint16 actResult[9];

	// Generate reference result
	expected(dataIn8X, expResult);

	// Apply stimulus to generate HLS result
	hls_func(dataIn8X, actResult);

	// Compare actual and expected results
	for( int i=0; i<9; i++)
	{
		printf("i: %d, Expected: %d, Actual: %d\n", i, expResult[i], actResult[i]);
		if( expResult[i] != actResult[i] )
		{
			fail = 1;
			break;
		}
	}

	if( fail )	printf("Test Failed!!!\n");
	else		printf("Test Passed\n");
	return 0;
}
