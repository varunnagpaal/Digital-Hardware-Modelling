#include <stdio.h>
#include <stdlib.h>
#include "gcd.h"

typedef struct
{
	din_t A;
	din_t B;
	dout_t R;
}IO_Type;

IO_Type stimulus[5] = {	{5,7,1},
						{15,9,3},
						{270, 192, 6},
						{16, 106, 2},
						{60, 36, 12}
					  };
int main()
{
	din_t A, B;
	dout_t RES;
	int i, retval;

	FILE *fp;

	fp=fopen("result.dat","w");

	// Apply Stimulus and generate result
	for(i=0;i<5;++i)
	{
		gcd(stimulus[i].A, stimulus[i].B, &(stimulus[i].R));
		fprintf(fp, "%d %d %d\n", stimulus[i].A, stimulus[i].B, stimulus[i].R );
		printf("%d %d %d\n", stimulus[i].A, stimulus[i].B, stimulus[i].R );
	}
	fclose(fp);

	// Compare result
	retval = system("diff --brief -w result.dat result.golden.dat");
	if (retval != 0) {
		printf("Test failed  !!!\n");
		retval=1;
	} else {
		printf("Test passed !\n");
  }

	// Return 0 if the test passed
  return retval;
}
