/*
:section: 35.5.4 Import declarations
:summary: All DPI imports bound to one C name must share identical type signatures.
:type: elaboration
:should_fail_because: two imports bind c_identifier clash with different signatures
*/
module top;
  import "DPI-C" function int clash(input int x);
  import "DPI-C" clash = function real other_clash(input real x);
endmodule
