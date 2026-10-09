/*
:section: 27.4 Loop generate constructs
:summary: A genvar may only be used inside a loop generate scheme, not in procedural code.
:type: elaboration
:should_fail_because: a genvar is read in a procedural statement
*/
module top;
  genvar g;
  int v;
  initial v = g;
endmodule
