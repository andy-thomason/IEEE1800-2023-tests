#include <string.h>
#include <stdint.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

int bit_at(const svBitVecVal *m, int index) { return (m[index / 32] >> (index % 32)) & 1; }

#ifdef __cplusplus
}
#endif
