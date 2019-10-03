#include "ackHLS_common.h"
#include <stdio.h>

/*
void ackHLSExpected(X_T x, Y_T y, OUT_T *pVal)
{
	switch (x)
	{
	case 0: if (y <= UINT64_MAX - 1) *pVal = y + 1;
			else *pVal = 0;
			break;

	case 1: if (y <= UINT64_MAX - 2) *pVal = y + 2;
			else *pVal = 0;
			break;

	case 2: if (y <= (UINT64_MAX - 3) >> 1) *pVal = 2 * y + 3;
			else *pVal = 0;
			break;

	case 3: if (y <= 61) *pVal = ((OUT_T)1 << (y + 3)) - 3;
			else *pVal = 0;
			break;

	case 4: if (y == 0) *pVal = 13;
			else if (y == 1) *pVal = 65533;
			else *pVal = 0;
			break;

	case 5: if (y == 0) *pVal = 65533;
			else *pVal = 0;
			break;

	default: *pVal = 0;
		break;
	}
}
*/
int main()
{
	X_T	   x;
	Y_T	   y;
	OUT_T  out;
	BOOL_T done;

	/*
	x = 2;
	y = 4;
	done = ackHLS(x,y,&out);

	x = 3;
	y = 4;
	done = ackHLS(x,y,&out);

	x = 4;
	y = 1;
	done = ackHLS(x,y,&out);
*/
	x = 3;
	y = 20;
	done = ackHLS(x,y,&out);

	printf("\nAck(%llu, %llu): %llu\n", (unsigned long long)x, (unsigned long long)y, (unsigned long long)out);
	/*
	X_T	   x_in;
	Y_T	   y_in;
	OUT_T  expected_out;
	OUT_T  actual_out;

	printf("x max: ");
	scanf_s("%hhu", &x_in);

	printf("y max: ");
	scanf_s("%Iu", &y_in);

	for (X_T m = x_in; m >= 0 && m <= x_in; m--)
	{
		for (Y_T n = y_in; n >= 0 &&  n <= y_in; n--)
		{
			ackHLS(m, n, &actual_out);
			ackHLSExpected(m, n, &expected_out);
			printf("A(%u, %u): %llu (expected), %llu (actual). %s\n",
					m,
					n,
					expected_out,
					actual_out,
					((expected_out == actual_out) ? "PASS" : "FAIL"));
		}
	}
	*/
	return 0;
}
