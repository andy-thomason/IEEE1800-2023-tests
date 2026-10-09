#include <string.h>
#include <stdint.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

void query(const svOpenArrayHandle a, int *r) {
    r[0] = svDimensions(a);
    r[1] = svLeft(a, 1); r[2] = svRight(a, 1); r[3] = svLow(a, 1); r[4] = svHigh(a, 1);
    r[5] = svIncrement(a, 1);
    r[6] = svSize(a, 2);
    r[7] = svSize(a, 0);
}

#ifdef __cplusplus
}
#endif
