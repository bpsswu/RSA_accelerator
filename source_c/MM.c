#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <stdbool.h>

bool masking(uint64_t input, int n);
uint64_t MM(uint64_t A, uint64_t B, uint64_t N);

int count = 0;

int main() {
    uint64_t A, B, N;
    N = 128255609;
    A = 75431153;
    B = 52525252;
	
	printf("A = %llu\n", A);    
	printf("B = %llu\n", B);    
	printf("N = %llu\n", N);
	printf("MM(A, B, N) = %llu\n", MM(A, B, N));
	printf("while loop count = %d\n", count);
    return 0;
}

bool masking(uint64_t input, int n) {
    input = input >> n;
    input = input & 1;
    return input;
}

uint64_t MM(uint64_t A, uint64_t B, uint64_t N) {
    uint64_t Z = 0;
    for (int i = 0; i < 32; i++)
	{
        Z += masking(A, i) * B;
        Z += masking(Z, 0) * N;
        Z = Z >> 1;
    }

	printf("Z = %llu\n", Z);	

    while (Z > N)
	{
		count++;
        Z -= N;       
    }
    return Z;
}
