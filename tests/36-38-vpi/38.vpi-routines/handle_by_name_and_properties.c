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

static PLI_INT32 probe(PLI_BYTE8 *u) {
    vpiHandle bus = vpi_handle_by_name((PLI_BYTE8 *)"top.bus", NULL);
    vpiHandle inner = vpi_handle_by_name((PLI_BYTE8 *)"top.u.inner", NULL);
    vpiHandle inst = vpi_handle_by_name((PLI_BYTE8 *)"top.u", NULL);
    int t = bus ? vpi_get(vpiType, bus) : 0;
    put_int(arg(0), bus ? vpi_get(vpiSize, bus) : -1);
    put_int(arg(1), t == vpiReg || t == vpiLogicVar);
    put_int(arg(2), inner && !strcmp(vpi_get_str(vpiName, inner), "inner") &&
                    !strcmp(vpi_get_str(vpiFullName, inner), "top.u.inner"));
    put_int(arg(3), inst && !strcmp(vpi_get_str(vpiDefName, inst), "sub"));
    return 0;
}
static void reg(void) { reg_tf(vpiSysTask, "$t_probe", probe, NULL, NULL); }
void (*vlog_startup_routines[])(void) = { reg, 0 };
