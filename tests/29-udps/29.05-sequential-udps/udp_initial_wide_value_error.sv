/*
:section: 29.7 Sequential UDP initialization
:summary: A UDP initial statement may only assign a single-bit 0, 1 or x value, not 2'b10.
:type: parse
:should_fail_because: the UDP initial statement assigns 2'b10
*/
primitive wide_init (q, s);
  output q;
  reg q;
  input s;
  initial q = 2'b10;
  table
    1 : ? : 1;
    0 : ? : -;
  endtable
endprimitive
  module top;
  endmodule
