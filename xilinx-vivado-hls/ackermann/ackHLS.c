#include "ackHLS_common.h"

void ackHLS(X_T x,Y_T y, OUT_T *pResult)
{
	X_T I = x;
	OUT_T xar[N];
    OUT_T sum[N];
	OUT_T result = 0;
	OUT_T i;
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
		result = xar[0] + 1;
		transfer = 1;

		while (transfer)
			{
				if (xar[i] == sum[i])
				{
					sum[i] = result;
				}
				else
				{
					transfer = 0;
				}

				xar[i] += 1;
				i++;
			}
	} while (xar[x] < y + 1);

	*pResult = result;
}
