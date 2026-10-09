#include <string.h>
#include <stdint.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

/* 0: a0 b0, 1: a1 b0, z: a0 b1, x: a1 b1 */
int encoding_ok(const svLogicVecVal *v) {
    return (v[0].aval & 0xf) == 0xa && (v[0].bval & 0xf) == 0xc;
}
void make_xz(svLogicVecVal *v) { v[0].aval = 0x9; v[0].bval = 0x3; }

#ifdef __cplusplus
}
#endif
