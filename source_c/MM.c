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
    N = 100000;
    A = 67676767;
    B = 52525252;
	
	printf("A = %lu\n", A);    
	printf("B = %lu\n", B);    
	printf("N = %lu\n", N);
	printf("MM(A, B, N) = %lu\n", MM(A, B, N));
    return 0;
}

bool masking(uint64_t input, int n) {
    input = input >> n;
    input = input & 1;
    return input;
}

uint64_t MM(uint64_t A, uint64_t B, uint64_t N) {
    uint64_t Z = 0;
	
	printf("\n");
    for (int i = 0; i < 32; i++)
	{
        Z += masking(A, i) * B;
		// printf("%d : Z = %lu\n", 3 * i + 1, Z);	
        Z += masking(Z, 0) * N;
		// printf("%d : Z = %lu\n", 3 * i + 2, Z);	
        Z = Z >> 1;
		// printf("%d : Z = %lu\n", 3 * i + 3, Z);	
    	// printf("\n");
	}

	while (Z > N)
	{
		count++;
        Z -= N;       
    }
	
	printf("while loop count = %d\n", count);
    
	return Z;
}
