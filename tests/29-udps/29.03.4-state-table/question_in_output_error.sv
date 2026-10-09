/*
:section: 29.3.6 Summary of symbols
:summary: The ? symbol is not allowed in a UDP output field.
:type: parse
:should_fail_because: ? appears in an output field
*/
primitive q_out (y, a);
  output y;
  input a;
  table
    0 : ?;
  endtable
endprimitive
  module top;
  endmodule
