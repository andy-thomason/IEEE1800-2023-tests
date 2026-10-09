#include <string.h>
#include <stdint.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

int scalar_code(svLogic l) { return l; }
int ubyte_plus(unsigned char b, unsigned short s) { return b + s; }
int bits8(const svBitVecVal *b) { return b[0] & 0xff; }

#ifdef __cplusplus
}
#endif
