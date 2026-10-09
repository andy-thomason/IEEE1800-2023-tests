/*
:section: 7.3 Unions
:summary: A packed dimension on a union requires the soft or packed keyword.
:type: parse
:should_fail_because: a packed dimension follows a union that is neither soft nor packed
*/
module top;
  union { bit [3:0] a; bit [3:0] b; } [1:0] pair;
endmodule
