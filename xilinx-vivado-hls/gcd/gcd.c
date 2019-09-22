#include "gcd.h"

void gcd (din_t a, din_t b, dout_t *pResult )
{
	dio_t result = a;

	while( a != b )
	{
		if( a > b )
		{
			a = a-b;
		}
		else
		{
			b = b-a;
		}
	}
	result = a;
	*pResult = result;
}
