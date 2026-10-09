/*
:section: 22.5.1 `define
:summary: Macro text must not break a string literal across the macro boundary.
:type: parse
:should_fail_because: the macro text splits a string literal
*/
`define BROKEN "half
module top;
  string s = `BROKEN string";
endmodule
