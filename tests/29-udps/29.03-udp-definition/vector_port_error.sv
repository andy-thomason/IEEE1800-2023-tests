/*
:section: 29.3.1 UDP header
:summary: UDP ports must be single-bit; a vector input declaration is illegal.
:type: parse
:should_fail_because: a UDP input is a vector
*/
primitive wide (y, a);
  output y;
  input [1:0] a;
  table
    0 : 0;
  endtable
endprimitive
  module top;
  endmodule
