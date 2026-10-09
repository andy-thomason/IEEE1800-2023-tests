/*
:section: 35.5.2 Pure functions
:summary: A DPI import declared pure must not have output or inout arguments.
:type: elaboration
:should_fail_because: a pure import has an output argument
*/
module top;
  import "DPI-C" pure function int bad_pure(output int o);
endmodule
