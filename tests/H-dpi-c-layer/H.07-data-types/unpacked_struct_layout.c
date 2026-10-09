#include <string.h>
#include <stdint.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct { int count; double scale; char tag; } rec_t;
double rec_value(const rec_t *r) { return r->count * r->scale + r->tag; }
void rec_fill(rec_t *r) { r->count = 7; r->scale = 0.25; r->tag = -1; }

#ifdef __cplusplus
}
#endif
