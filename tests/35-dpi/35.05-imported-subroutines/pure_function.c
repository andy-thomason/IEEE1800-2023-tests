#include <string.h>
#include <math.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

int gcd(int a, int b) { while (b) { int t = a % b; a = b; b = t; } return a; }

#ifdef __cplusplus
}
#endif
