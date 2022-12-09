#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <stdbool.h>
#include <memory.h>
#include <time.h>

clock_t clock(void);
void RL_binary(uint64_t* base, uint64_t* exp, uint64_t* N, uint64_t* res, uint64_t* map);
bool check_data(uint64_t* x, uint64_t* y);
bool masking(uint64_t input, int n);
void mod_exp(uint64_t* A, uint64_t* B, uint64_t* N, uint64_t* map);
void WMM(uint64_t* a, uint64_t* b, uint64_t* n, uint64_t* res);
void print(uint64_t* a, char* ch);
void long_div(uint64_t* rem, uint64_t* N, uint64_t* res);
bool carry_check(uint64_t x);

int main() {
    uint64_t M[64] = { 0, };
    uint64_t R[64] = { 0, };
    uint64_t N[64] = { 1772468079, 1026965732, 3854392804, 681157401, 2242704601, 645208850, 517937797, 1118753890, 1134620405, 2796796052, 44775547, 1561238577, 3587829855, 1705089449, 601200013, 2686539155, 2146055393, 685453032, 2057111543, 2922298994, 2527866043, 295361383, 2263059387, 3211700054, 7864122, 3946523924, 2661803529, 2112650482, 1137893555, 3385895219, 372234895, 886679051, 2327194129, 2244927350, 332824831, 3917153180, 905774481, 1571505563, 3583966478, 2825949764, 2291408092, 2709651032, 1972017760, 2480045715, 1289615940, 2779978546, 3343929325, 2232773253, 4078916511, 939479526, 2922633257, 3788436804, 263430693, 1637486380, 349442355, 1456292476, 2137672612, 222773557, 445261029, 608202616, 2627542073, 2672786269, 2415032310, 3003653581 };
    uint64_t e[64] = { 0, };
    uint64_t d[64] = { 324868189, 4281216638, 3318549412, 2180810484, 1788339416, 3628050066, 2410544322, 1746041666, 4151987154, 580376128, 3937161041, 3978329192, 1979045924, 3826243206, 903295982, 493321907, 3863092007, 432140987, 295579283, 2869775938, 3664968783, 3712889056, 2899087379, 4251344557, 1487971787, 986333661, 27749494, 1491745676, 2079977165, 2234779023, 595978717, 1302759124, 1644518640, 1259964532, 3142649716, 3945867969, 1342294262, 3214864545, 678284717, 2911560623, 68766809, 2324732248, 1789766451, 1071236133, 878441268, 2700232618, 268535242, 1206401521, 2271133319, 1039257098, 1784000834, 3970170479, 1506288293, 443617945, 404701862, 3226990271, 3082029710, 4154398641, 3112454312, 3481578849, 572639171, 2273923565, 125111088, 762996097 };
    uint64_t C[64] = { 0, };
    uint64_t Cipher[64] = { 1662854447, 1878974743, 564694113, 58234971, 2426677176, 3384723388, 122002931, 3703559213, 3812269714, 3322982422, 1470448015, 409529075, 3315378378, 1015957442, 2651982914, 2756991066, 575016612, 1327414958, 1547560534, 4229062572, 4248772335, 3629832227, 3749634655, 2953955221, 2516265643, 115582104, 3619073258, 3535827275, 2760936177, 4097466231, 3016011913, 2579805315, 2074927571, 2506799660, 4263538996, 2750346946, 672744300, 232021506, 952138069, 3425252361, 278915094, 3384898057, 1233657429, 2790475108, 964581799, 1403182248, 2014367741, 3889400497, 272444930, 2864085951, 3257186255, 88730020, 2612881635, 3849829631, 1076331430, 2016109295, 2133753977, 2087559665, 4155169039, 1820818380, 3367909418, 1716338192, 1124931825, 100036484 };
    uint64_t res[64] = { 0, };
    uint64_t map[64] = { 0, };
    for (int i = 0; i < 64; i++) { M[i] = 12456234; }
    for (int i = 0; i < 64; i++) { R[i] = (uint64_t)((uint64_t)pow(2, 32) - 1 - N[i]); } //R = R-N
    R[63] += 1;
    e[63] = 65537;
    long_div(R, N, map);
    double start, end;

    printf("Input message = \n");
    print(M, "M");

    start = (double)clock();
    RL_binary(M, e, N, C, map);
    printf("Cipher_text   = \n");
    print(C, "C");
    end = (double)clock();
    printf("encryption time : %lfms\n\n", (end - start));

    start = (double)clock();
    RL_binary(C, d, N, res, map);
    printf("Plain_text    = \n");
    print(res, "res");
    end = (double)clock();

    printf("decryption time : %lfms\n\n", (end - start));
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
//check bit[31] before shift
bool carry_check(uint64_t x) {
    if (masking(x, 31)) return 1;
    else return 0;
}
//size comparison
bool check_data(uint64_t* x, uint64_t* y) {
    for (int i = 0; i < 64; i++) {
        if (x[i] == y[i]) continue;
        else if (x[i] > y[i]) return 1;
        else return 0;
    }
    return 666;
}

void RL_binary(uint64_t* base, uint64_t* exp, uint64_t* N, uint64_t* res, uint64_t* map) {
    int m = 0;
    int count = 0;
    uint64_t x[64] = { 0, };
    x[63] = 1;
    for (int i = 0; i < 64; i++) { res[i] = x[i]; }
    //print(res, "result");
    uint64_t y[64] = { 0, };
    y[63] = 1;
    for (int i = 0; i < 64; i++) { y[i] = base[i]; }
    //print(y, "y");
    for (int i = 63; i > -1; i--) {
        for (int j = 0; j < 32; j++) {
            if (masking(exp[i], m)) {
                //printf("remain calculate\n\n");
                mod_exp(res, y, N, map);

                //print(res, "res");
            }
            //printf("y calculate\n\n");
            mod_exp(y, y, N, map);
            //print(y, "y");
            m++;
        }
        m = 0;
    }
}

void mod_exp(uint64_t* A, uint64_t* B, uint64_t* N, uint64_t* map)
{
    uint64_t mult[64] = { 0, };
    uint64_t buf1[64] = { 0, };
    uint64_t buf2[64] = { 0, };
    uint64_t one[64] = { 0, };
    one[63] = 1;

    //A�� B�� ���� �����Ͽ� ��� Ȯ��

    WMM(A, map, N, buf1);
    WMM(B, map, N, buf2);
    WMM(buf1, buf2, N, mult);
    WMM(mult, one, N, A);

}

void WMM(uint64_t* a, uint64_t* b, uint64_t* n, uint64_t* res) {
    uint64_t T[64] = { 0, };
    uint64_t carry = 0;
    uint64_t Ts = 0; // T[s]
    uint64_t u = 0; // T[s+1] = u
    uint64_t S = 0; // sumation
    uint64_t m = 0;
    uint64_t np = 1529735419;
    uint64_t R = (uint64_t)pow(2, 32);

    for (int i = 63; i > -1; i--) {
        for (int j = 63; j > -1; j--) {
            S = T[j] + a[j] * b[i] + carry;
            carry = S >> 32;
            T[j] = S % R;
        }
        S = Ts + carry;
        u = S >> 32;
        Ts = S % R;

        m = (T[63] * np) % R;
        S = T[63] + m * n[63];
        carry = S >> 32;
        for (int h = 62; h > -1; h--) {
            S = T[h] + m * n[h] + carry;
            carry = S >> 32;
            T[h + 1] = S % R;
        }
        S = Ts + carry;
        carry = S >> 32;
        T[0] = S % R;
        Ts = u + carry;
        carry = 0;
    }
    //print(T, "T");

    if (T > n) {
        for (int i = 63; i > 0; i--) {
            if (T[i] < n[i] && i < 63) {
                T[i + 1] = T[i + 1] - 1;
                T[i] = R - (n[i] - T[i]);
            }
            else T[i] = T[i] - n[i];
        }
    }
    for (int i = 0; i < 64; i++) { res[i] = T[i]; }
    //print(z, "z");
    //print(res, "res");
}

void long_div(uint64_t* rem, uint64_t* N, uint64_t* res) {//remain = (R-N)
    int Carry = 0;
    uint64_t R = (uint64_t)pow(2, 32);
    uint64_t remain[64] = { 0, };
    for (int i = 0; i < 64; i++) { remain[i] = rem[i]; }
    //if remain > N, make remain smaller than N
    while (check_data(remain, N)) {
        for (int i = 0; i < 64; i++) {
            if (remain[i] >= N[i]) {
                remain[i] -= N[i];
            }
            else {
                remain[i] += (R - N[i]);
                remain[i - 1] -= 1;
            }
        }
    }
    //print(remain, "remain"); //check remain
    for (int c = 0; c < 2048; c++) {
        //shift start
        if (carry_check(remain[0])) {
            Carry = 1;
            remain[0] = remain[0] << 1;
            remain[0] -= R;
        }
        else {
            Carry = 0;
            remain[0] = remain[0] << 1;
        }
        for (int i = 1; i < 64; i++) {
            if (carry_check(remain[i])) {
                remain[i - 1] += 1;
                remain[i] = remain[i] << 1;
                remain[i] -= R;
            }
            else { remain[i] = remain[i] << 1; }
        }
        //shift end

        if (Carry) {
            for (int i = 0; i < 64; i++) {
                remain[i] = remain[i] + rem[i];
                Carry = 0;
                if (carry_check(remain[i]) && i != 0) {
                    remain[i - 1] += 1;
                    remain[i] -= R;
                }
            }
            if (check_data(remain, N)) {
                for (int j = 0; j < 64; j++) {
                    if (remain[j] >= N[j]) {
                        remain[j] -= N[j];
                    }
                    else {
                        remain[j] += (R - N[j]);
                        remain[j - 1] -= 1;
                    }
                }
            }
        }
        //carry �����Ƿ� �E�� �� ���� �Ǵ�
        else {
            if (check_data(remain, N)) {
                for (int i = 0; i < 64; i++) {
                    if (remain[i] >= N[i]) {
                        remain[i] -= N[i];
                    }
                    else {
                        remain[i] += (R - N[i]);
                        remain[i - 1] -= 1;
                    }
                }
            }
        }
    }
    
    for (int i = 0; i < 64; i++) { res[i] = remain[i]; }
}