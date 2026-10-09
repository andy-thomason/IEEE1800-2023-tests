#include <string.h>
#include <stdint.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

void edit(svBitVecVal *v, int *got, int *sel) {
    svBitVecVal d = 0xdead0000u;
    *got = svGetBitselBit(v, 16);
    svGetPartselBit(&d, v, 16, 8);
    *sel = (int)d;
    svPutPartselBit(v, 0x5u, 32, 4);
    svPutBitselBit(v, 0, 1);
}
void edit4(svLogicVecVal *v) {
    svPutBitselLogic(v, 5, sv_z);
    svPutBitselLogic(v, 0, sv_x);
}

#ifdef __cplusplus
}
#endif
