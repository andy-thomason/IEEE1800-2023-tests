#include <string.h>
#include <stdint.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

int low_bit(const svBitVecVal *v) { return v[0] & 1; }
int first_elem(const int *a) { return a[0]; }

#ifdef __cplusplus
}
#endif
