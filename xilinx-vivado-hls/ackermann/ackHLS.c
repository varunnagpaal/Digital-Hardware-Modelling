#include "ackHLS_common.h"

BOOL_T ackHLS(X_T x,Y_T y, OUT_T *pResult)
{
	X_T I = x;
	static OUT_T xar[N];
	static OUT_T sum[N];
	int i;
	OUT_T finalValue = 0;
	BOOL_T done = 0;
	int transfer;
	for (int n = 0;n <= I;n++)
	{
		xar[n] = 0;
		sum[n] = 1;
	}
	sum[I] = -1;
	do
	{
		i = 0;
		finalValue = xar[0] + 1;
		transfer = 1;

		while (transfer)
			{
				if (xar[i] == sum[i])
				{
					sum[i] = finalValue;
				}
				else
				{
					transfer = 0;
				}

				xar[i] += 1;
				i++;
			}
	} while (xar[x] < y + 1);

	*pResult = finalValue;
	return done = 1;
}
