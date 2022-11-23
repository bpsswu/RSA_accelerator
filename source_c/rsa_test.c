#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <stdbool.h>
#include <memory.h>

void RL_binary(uint64_t* base, uint64_t* exp, uint64_t* N, uint64_t* res, uint64_t* MF);
bool check_data(uint64_t* x, uint64_t* y);
bool masking(uint64_t input, int n);
void mod_exp(uint64_t* A, uint64_t* B, uint64_t* N, uint64_t* MF);
void WMM(uint64_t* a, uint64_t* b, uint64_t* n, uint64_t* res);
void print(uint64_t* a, char* ch);
void long_div(uint64_t* rem, uint64_t* N, uint64_t* res);
bool carry_check(uint64_t x);

int main()
{
    uint64_t M[64] = { 0, };
    for (int i = 0; i < 64; i++) { M[i] = 1; }
    uint64_t N[64] = { 1772468079, 1026965732, 3854392804, 681157401, 2242704601, 645208850, 517937797, 1118753890, 1134620405, 2796796052, 44775547, 1561238577, 3587829855, 1705089449, 601200013, 2686539155, 2146055393, 685453032, 2057111543, 2922298994, 2527866043, 295361383, 2263059387, 3211700054, 7864122, 3946523924, 2661803529, 2112650482, 1137893555, 3385895219, 372234895, 886679051, 2327194129, 2244927350, 332824831, 3917153180, 905774481, 1571505563, 3583966478, 2825949764, 2291408092, 2709651032, 1972017760, 2480045715, 1289615940, 2779978546, 3343929325, 2232773253, 4078916511, 939479526, 2922633257, 3788436804, 263430693, 1637486380, 349442355, 1456292476, 2137672612, 222773557, 445261029, 608202616, 2627542073, 2672786269, 2415032310, 3003653581 };
    uint64_t e[64] = { 0, };
    uint64_t d[64] = { 324868189, 4281216638, 3318549412, 2180810484, 1788339416, 3628050066, 2410544322, 1746041666, 4151987154, 580376128, 3937161041, 3978329192, 1979045924, 3826243206, 903295982, 493321907, 3863092007, 432140987, 295579283, 2869775938, 3664968783, 3712889056, 2899087379, 4251344557, 1487971787, 986333661, 27749494, 1491745676, 2079977165, 2234779023, 595978717, 1302759124, 1644518640, 1259964532, 3142649716, 3945867969, 1342294262, 3214864545, 678284717, 2911560623, 68766809, 2324732248, 1789766451, 1071236133, 878441268, 2700232618, 268535242, 1206401521, 2271133319, 1039257098, 1784000834, 3970170479, 1506288293, 443617945, 404701862, 3226990271, 3082029710, 4154398641, 3112454312, 3481578849, 572639171, 2273923565, 125111088, 762996097 };
    uint64_t* C = (uint64_t*)calloc(64, sizeof(uint64_t));
    uint64_t* res = (uint64_t*)calloc(64, sizeof(uint64_t));
    e[63] = 65537;
    uint64_t R[64] = { 0, };
    uint64_t MF[64] = { 0, };
    uint64_t r = (uint64_t)pow(2, 32);
    for (int i = 0; i < 64; i++) { R[i] = (uint64_t)((uint64_t)pow(2, 32) - 1 - N[i]); } //R = R-N
    R[63] += 1;
    //여기까진 세팅
    //test
    //WMM(R,R,N,MF) //R mod N
    //long_div(one,N,MF) // R mod N
    uint64_t x[64] = { 0, };
    x[63] = 1;
    long_div(x, N, MF);
    print(MF, "MF");
    print(R, "R");
 //   //while (check_data(R, N)) { //remain이 N보다 작아질 때까지 modulus
 ////    for (int i = 0; i < 64; i++) {
 ////        if (R[i] >= N[i]) {
 ////            R[i] -= N[i];
 ////        }
 ////        else {
 ////            R[i] += (r - N[i]);
 ////            R[i - 1] -= 1;
 ////        }
 ////    }
 ////    print(R, "R");
 ////}

    long_div(M, N, MF);
    print(MF, "MF");

    print(R, "R");
    long_div(R, N, MF);
    print(MF, "MF");


    printf("Input message = \n");
    print(M, "M");

    RL_binary(M, e, N, C, MF);
    printf("Cipher_text   = \n");
    print(C, "C");

    RL_binary(C, d, N, res, MF);
    printf("Plain_text    = \n");
    print(res, "res");

    return 0;
}

void print(uint64_t* a, char* ch) {
    printf("%s : \n", ch);
    for (int i = 0; i < 64; i++) { printf("%llu, ", a[i]); if (i % 8 == 7) printf("\n\n"); }
}
bool masking(uint64_t input, int n) {
    input = input >> n;
    input = input & 1;
    return input;
}
bool carry_check(uint64_t x) {
    if (masking(x, 31)) return 1;
    else return 0;
}
bool check_data(uint64_t* x, uint64_t* y) {
    for (int i = 0; i < 64; i++) {
        if (x[i] == y[i]) continue;
        else if (x[i] > y[i]) return 1;
        else return 0;
    }
    return 666;
}

void RL_binary(uint64_t* base, uint64_t* exp, uint64_t* N, uint64_t* res, uint64_t* MF) {
    int m = 0;
    int count = 0;
    uint64_t x[64] = { 0, };
    x[63] = 1;
    for (int i = 0; i < 64; i++) { res[i] = x[i]; }
    print(res, "result");
    uint64_t y[64] = { 0, };
    y[63] = 1;
    for (int i = 0; i < 64; i++) { y[i] = base[i]; }
    print(y, "y");
    for (int i = 63; i > -1; i--) {
        for (int j = 0; j < 32; j++) {
            if (masking(exp[i], m)) {
                //printf("remain calculate\n\n");
                mod_exp(res, y, N, MF);
                //print(res, "res");
            }
            //printf("y calculate\n\n");
            mod_exp(y, y, N, MF);
            //print(y, "y");
            m++;
            //            count++;
            //            printf("count : %d\n", count);
            //            printf("\n");
        }
        m = 0;
    }
}

void mod_exp(uint64_t* A, uint64_t* B, uint64_t* N, uint64_t* MF)
{
    //A와 B를 직접 매핑하여 결과 확인
    /*
    long_div(A,N,buf1);
    long_div(B,N,buf2);
    WMM(buf1,buf2,N,mult);
    WMM(mult,one,N,A);

    */
    //print(MF, "MF");
    uint64_t mult[64] = { 0, };
    uint64_t buf2[64] = { 0, };
    uint64_t buf3[64] = { 0, };
    uint64_t one[64] = { 0, };
    one[63] = 1;
    WMM(A, MF, N, buf2); //A를 매핑
    //print(buf2,"buf2");
    WMM(B, MF, N, buf3); //B를 매핑
    //print(buf3, "buf3");
    WMM(buf2, buf3, N, mult);// 매핑 결과를 통해 연산
    //print(mult, "mult");
    WMM(mult, one, N, A); // 역매핑
    //print(A,"A");
}

void WMM(uint64_t* a, uint64_t* b, uint64_t* n, uint64_t* res) {
    uint64_t z[64] = { 0, };
    uint64_t x[64] = { 0, };
    uint64_t u = 0;
    uint64_t S = 0;
    uint64_t R = (uint64_t)pow(2, 32);
    uint64_t Ca, Cb;
    uint64_t np = 2939277029;

    for (int i = 63; i > -1; i--) {
        S = a[i] * b[63] + z[63];             // �����÷ο� ���� �ȳ�
        Ca = S / R;
        z[63] = S % R;                       //Ca = S[63:32], z[0] = S[31:0];
        x[i] = (z[63] * np) % R;             //np = -n[0] mod W
        //x[i] = mult[31:0];
        S = z[63] + x[i] * n[63];
        Cb = S / R;
        z[63] = S % R;                       //Cb = S[63:32], z[0] = S[31:0];
        for (int j = 62; j > -1; j--) {
            S = z[j] + a[i] * b[j] + Ca;    // �ִ� 2^64 -1�� �����÷ο� ���� �ȳ�
            Ca = S / R;
            z[j] = S % R;                   //Ca = S[63:32], z[j] = S[31:0];
            S = z[j] + x[i] * n[j] + Cb;
            Cb = S / R;
            z[j + 1] = S % R;                   //Cb = S[63:32], z[j - 1] = S[31:0];
        }
        S = Ca + Cb + u;
        u = S / R;
        z[0] = S % R;//u = S[63:32], z[s - 1] = S[31:0];
    }
    if (z > n) {
        for (int i = 63; i > 0; i--) {
            if (z[i] < n[i] && i < 63) {
                z[i + 1] = z[i + 1] - 1;
                z[i] = R - (n[i] - z[i]);
            }
            else z[i] = z[i] - n[i];
        }
    }
    for (int i = 0; i < 64; i++) { res[i] = z[i]; }
    //print(z, "z");
    //print(res, "res");
}

void long_div(uint64_t* rem, uint64_t* N, uint64_t* res) {
    int Carry = 0;
    uint64_t R = (uint64_t)pow(2, 32);
    uint64_t remain[64] = { 0, };
    for (int i = 0; i < 64; i++) { remain[i] = rem[i]; }
    while (check_data(remain, N)) { //remain이 N보다 작아질 때까지 modulus
        for (int i = 0; i < 64; i++) {
            if (remain[i] >= N[i]) {
                remain[i] -= N[i];
            }
            else {
                remain[i] += (R - N[i]);
                remain[i - 1] -= 1;
            }
        }
        print(remain, "remain");
    }

    for (int c = 0; c < 2048; c++) {
        //shift 시작
        if (carry_check(remain[0])) {
            //printf("remain[0] : %llu\n", remain[0]);
            Carry = 1;
            remain[0] = remain[0] << 1;
            remain[0] -= R;
            //printf("after remain[0] : %llu\n", remain[0]);
        }
        else {
            //printf("remain[0] : %llu\n", remain[0]);
            remain[0] = remain[0] << 1;
            Carry = 0;
            //printf("after remain[0] : %llu\n", remain[0]);
        }
        //remain[0]을 제외한 요소 shifting
        for (int i = 1; i < 64; i++) {
            if (carry_check(remain[i])) {
                //printf("%dth remain[0] : %llu\n", i, remain[i]);
                remain[i - 1] += 1;
                remain[i] = remain[i] << 1;
                remain[i] -= R;
                //printf("%dth remain[0] : %llu\n",i, remain[i]);
            }
            else {
                //printf("%dth remain[0] : %llu\n", i, remain[i]);
                remain[i] = remain[i] << 1;
                //printf("%dth remain[0] : %llu\n",i, remain[i]);
            }
        }
        //remain - N 시작
        if (Carry) {
            for (int i = 0; i < 64; i++) {
                remain[i] = remain[i] + rem[i]; Carry = 0;
                if (carry_check(remain[i]) && i != 0) {
                    remain[i - 1] += 1;
                    remain[i] -= R;
                }
            }
            //remain + rem이 N보다 클 경우 modulus
            if (check_data(remain, N)) {
                for (int j = 0; j < 64; j++) {
                    if (remain[j] >= N[j]) {
                        remain[j] -= N[j];
                    }
                    else {
                        remain[j] += ((uint64_t)pow(2, 32) - N[j]);
                        remain[j - 1] -= 1;
                    }
                }
            }
        }
        //carry 없으므로 뺼지 안 뺄지 생각
        else {
            if (check_data(remain, N)) {
                for (int i = 0; i < 64; i++) {
                    if (remain[i] >= N[i]) {
                        remain[i] -= N[i];
                    }
                    else {
                        remain[i] += ((uint64_t)pow(2, 32) - N[i]);
                        remain[i - 1] -= 1;
                    }
                }
            }
        }
    }
    //2048번 돈 후 결과 출력
    for (int i = 0; i < 64; i++) {
        res[i] = remain[i];
    }
}