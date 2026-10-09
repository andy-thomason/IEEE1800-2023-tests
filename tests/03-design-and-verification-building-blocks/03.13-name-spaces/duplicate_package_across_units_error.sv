/*
:section: 3.13 Name spaces
:summary: A package name defined in one compilation unit cannot be redefined in another unit.
:type: elaboration
:should_fail_because: package registry is defined in two compilation units; the package name space is global
:files: duplicate_package_across_units_error_other.svh
:flags-icarus: -u
*/
package registry;
  int a = 1;
endpackage

module top;
  initial $display("%0d", registry::a);
endmodule
