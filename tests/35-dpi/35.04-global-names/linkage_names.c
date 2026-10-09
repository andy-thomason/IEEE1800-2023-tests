#include <string.h>
#include <math.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

int plain_square(int x) { return x * x; }
int c_triple(int x) { return 3 * x; }
int begin(void) { return 99; }

#ifdef __cplusplus
}
#endif
