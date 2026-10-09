/*
:section: 22.5.1 `define
:summary: A text macro must not share its name with a compiler directive keyword such as
  include.
:type: parse
:should_fail_because: a macro is named after a compiler directive
*/
`define include 1
module top;
endmodule
