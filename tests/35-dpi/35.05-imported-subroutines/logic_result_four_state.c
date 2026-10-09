#include <string.h>
#include <math.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

svLogic r_logic(int which) {
    switch (which) { case 0: return sv_0; case 1: return sv_1; case 2: return sv_z; default: return sv_x; }
}

#ifdef __cplusplus
}
#endif
