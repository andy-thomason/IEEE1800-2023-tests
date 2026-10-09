#include <string.h>
#include <math.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

char r_byte(void) { return -5; }
short r_shortint(void) { return -30000; }
long long r_longint(void) { return 0x100000001LL; }
double r_real(void) { return 2.5; }
float r_shortreal(void) { return 0.75f; }
const char *r_string(void) { return "from C"; }
svBit r_bit(void) { return 1; }

#ifdef __cplusplus
}
#endif
