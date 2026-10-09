/*
:section: 6.8 Variable declarations
:summary: A struct with a packed dimension must itself be declared packed.
:type: parse
:should_fail_because: a packed dimension follows a struct that is not packed
*/
module top;
  struct { logic a; logic b; } [1:0] pair;
endmodule
