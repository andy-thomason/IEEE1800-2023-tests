#include <string.h>
#include <stdint.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

int words_ok(const svBitVecVal *v) {
    return v[0] == 0x12345678u && (v[1] & 0xffu) == 0xabu;
}
void make_wide(svBitVecVal *v) { v[0] = 0x0000beefu; v[1] = 0xcafe0000u; }

#ifdef __cplusplus
}
#endif
