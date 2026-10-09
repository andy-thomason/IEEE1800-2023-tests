#include <stdio.h>
#include <string.h>
#include "sv_vpi_user.h"

/* argument n (0-based) of the system task/function call being executed */
static vpiHandle arg(int n) {
    vpiHandle call = vpi_handle(vpiSysTfCall, NULL);
    vpiHandle it = vpi_iterate(vpiArgument, call);
    vpiHandle h = NULL;
    for (int i = 0; it && (h = vpi_scan(it)) != NULL; i++) {
        if (i == n) { vpi_free_object(it); return h; }
    }
    return NULL;
}
static int int_of(vpiHandle h) {
    s_vpi_value v;
    v.format = vpiIntVal;
    vpi_get_value(h, &v);
    return v.value.integer;
}
static void put_int(vpiHandle h, int x) {
    s_vpi_value v;
    v.format = vpiIntVal;
    v.value.integer = x;
    vpi_put_value(h, &v, NULL, vpiNoDelay);
}
static void ret_int(int x) { put_int(vpi_handle(vpiSysTfCall, NULL), x); }
static void reg_tf(int type, const char *name, PLI_INT32 (*calltf)(PLI_BYTE8 *),
                   PLI_INT32 (*compiletf)(PLI_BYTE8 *), PLI_INT32 (*sizetf)(PLI_BYTE8 *)) {
    s_vpi_systf_data d;
    memset(&d, 0, sizeof d);
    d.type = type;
    d.sysfunctype = vpiIntFunc;
    d.tfname = (PLI_BYTE8 *)name;
    d.calltf = calltf;
    d.compiletf = compiletf;
    d.sizetf = sizetf;
    vpi_register_systf(&d);
}

static int compiled = 0;
static PLI_INT32 marked_compiletf(PLI_BYTE8 *u) { compiled++; return 0; }
static PLI_INT32 noop(PLI_BYTE8 *u) { return 0; }
static PLI_INT32 count_calltf(PLI_BYTE8 *u) { ret_int(compiled); return 0; }
static void reg(void) {
    reg_tf(vpiSysTask, "$t_marked", noop, marked_compiletf, NULL);
    reg_tf(vpiSysFunc, "$t_compile_count", count_calltf, NULL, NULL);
}
void (*vlog_startup_routines[])(void) = { reg, 0 };
