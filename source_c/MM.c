#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <stdbool.h>

bool masking(uint64_t input, int n);
uint64_t MM(uint64_t A, uint64_t B, uint64_t N, int len);

int main()
{
    uint64_t A, B, N;
    N = 128255609;
    A = 67676767;
    B = 52525252;
	
	printf("A = %lu\n", A);    
	printf("B = %lu\n", B);    
	printf("N = %lu\n", N);
	printf("MM(A, B, N) = %lu\n", MM(A, B, N, 27));
    return 0;
}

bool masking(uint64_t input, int n)
{
    input = input >> n;
    input = input & 1;
    return input;
}

uint64_t MM(uint64_t A, uint64_t B, uint64_t N, int len)
{
    uint64_t Z = 0;

    for(int i = 0; i < len; i++)
    {
        Z += masking(A, i) * B;
        Z += masking(Z, 0) * N;
        Z = Z >> 1;
    }

    while (Z > N)
    {
		Z -= N;
    }

    return Z;
}
