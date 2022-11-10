#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <stdbool.h>

uint32_t *RL_binary(uint64_t base, uint64_t exp, uint64_t N);
int get_length(uint64_t input);
bool masking(uint64_t input, int n);
uint64_t long_div(uint64_t Msg, uint64_t N, int len);
uint32_t *mod_exp(uint64_t A, uint64_t B, uint64_t N, int len);
uint64_t MM(uint64_t A, uint64_t B, uint64_t N, int len);
uint32_t* WMM(uint32_t* a, uint32_t* b, uint32_t* n);

int main()
{
    uint32_t M[64] = {};
    uint32_t N[64] = {};
    uint32_t e[64] = {};
    uint32_t d[64] = {};
    uint32_t C[64] = 0;

    // printf("Input message = %lu\n", M);

    C = RL_binary(M, e, N);
    // printf("Cipher_text   = %lu\n", C);

    M = RL_binary(C, d, N);
    // printf("Plain_text    = %lu\n", M);

    return 0;
}

uint32_t *RL_binary(uint32_t *base, uint32_t *exp, uint32_t *N)
{
    int m = 0;
    uint64_t *r = 1;
    uint32_t *y = base;
    int N_length = get_length(N);
    for (int i = 0; i < 64; i++) {
        for (int j = 0; j < 32; j++) {
            if (masking(exp[i], m)) {
                r = mod_exp(r, y, N);
            }
            y = mod_exp(y, y, N);
            m++;
        }
    }
    return r;
}

int get_length(uint64_t input)
{
    int MSB_index = -1;
    if (input & 1) {
        MSB_index = 0;
    }
    for (int i = 1; i < 64; i++) {
        input = input >> 1;
        if (input & 1) {
            MSB_index = i;
        }
    }

    return MSB_index + 1;
}

bool masking(uint64_t input, int n)
{
    input = input >> n;
    input = input & 1;
    return input;
}

uint32_t *mod_exp(uint32_t *A, uint32_t *B, uint32_t *N)
{
    uint32_t R[64] = 0;
    for (int i = 64; i > 0; i--) {
        R[i] = (pow(2, 32) - 1) - N[i];
    }
    R[0] += 1;
    uint32_t map[64] = WMM(R, R, N);
    A = WMM(A, map, N);
    B = WMM(B, map, N);
    uint32_t mult[64] = WMM(A, B, N);
    A = WMM(mult, 1, N);
    return A;
}

uint32_t* WMM(uint32_t* a, uint32_t* b, uint32_t* n) {
    uint32_t z[64] = 0;
    uint32_t x[64] = 0;
    uint32_t u = 0;
    uint64_t S = 0;
    uint64_t R = pow(2, 32);
    uint32_t Ca, Cb;
    uint32_t np = 123;
    int s = 64;
    /*
    1. 63* 62번 도는 함수가 맞는지 모르겠음
    2. for do end가 2개이기 때문에 z[63]을 63번 구하는 코드이고 이는 어떠한 형태로 보아도 이상하다는 것을 알 수 있음
    3. 2중 포문이 맞는 것인가
    */
    
    // S = 64bit, Z = 2048bit, u = 64bit
    for (int i = 0; i < 63; i++) {
        S = a[i] * b[0] + z[0];             // 오버플로우 절대 안남
        Ca = S / R;
        z[0] = S & R;                       //Ca = S[63:32], z[0] = S[31:0];
        x[i] = (z[0] * np) & R;             //np = -n[0] mod W
            //x[i] = mult[31:0];
        S = z[0] + x[i] * n[0];
        Cb = S / R;
        z[0] = S & R;                       //Cb = S[63:32], z[0] = S[31:0];
        for (int j = 1; j < 63; j++) {
            S = z[j] + a[i] * b[j] + Ca;    // 최대 2^64 -1로 오버플로우 절대 안남
            Ca = S / R;
            z[0] = S & R;                   //Ca = S[63:32], z[j] = S[31:0];
            S = z[j] + x[i] * n[j] + Cb;
            Cb = S / R;
            z[0] = S & R;                   //Cb = S[63:32], z[j - 1] = S[31:0];
        }
        S = Ca + Cb + u;
        u = S / R;
        z[63] = S & R;//u = S[63:32], z[s - 1] = S[31:0];
    }
    if (z > n) {
        for (int i = 63; i >0; i--) {
            if (z[i] < n[i] && i < 63) {
                z[i + 1] = z[i + 1] - 1;
                z[i] = R - (n[i] - z[i]);
            }
            else z[i] = z[i] - n[i];
        }
    }
    return z;
}