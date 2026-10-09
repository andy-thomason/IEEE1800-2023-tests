/*
:section: 29.3.6 Summary of symbols
:summary: The no-change symbol - must not appear in the output column of a combinational UDP.
:type: parse
:should_fail_because: - appears in a combinational output
*/
primitive comb_dash (y, a);
  output y;
  input a;
  table
    0 : -;
  endtable
endprimitive
  module top;
  endmodule
