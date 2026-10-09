/*
:section: 35.5.2 Pure functions
:summary: A DPI import declared pure must not return void.
:type: elaboration
:should_fail_because: a pure import returns void
*/
module top;
  import "DPI-C" pure function void bad_pure_void(input int x);
endmodule
