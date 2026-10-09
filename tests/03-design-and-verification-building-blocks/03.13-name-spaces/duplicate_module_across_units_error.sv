/*
:section: 3.13 Name spaces
:summary: A module name used in one compilation unit cannot be reused for a module in another
  unit.
:type: elaboration
:should_fail_because: module twin is defined in two compilation units; the definitions name space is global
:files: duplicate_module_across_units_error_other.svh
:flags-icarus: -u
*/
module twin;
endmodule

module top;
  twin u_twin();
endmodule
