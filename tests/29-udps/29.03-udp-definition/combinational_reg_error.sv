/*
:section: 29.3.2 UDP port declarations
:summary: A combinational UDP may not declare its output as reg.
:type: parse
:should_fail_because: a UDP whose table has no state field declares reg y
*/
primitive comb_reg (y, a);
  output y;
  reg y;
  input a;
  table
    0 : 1;
    1 : 0;
  endtable
endprimitive
  module top;
  endmodule
