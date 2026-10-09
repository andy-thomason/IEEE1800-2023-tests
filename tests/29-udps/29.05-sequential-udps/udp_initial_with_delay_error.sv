/*
:section: 29.7 Sequential UDP initialization
:summary: A UDP initial statement must not contain a delay control.
:type: parse
:should_fail_because: the UDP initial statement has a delay
*/
primitive late_init (q, s);
  output q;
  reg q;
  input s;
  initial #1 q = 1;
  table
    1 : ? : 1;
    0 : ? : -;
  endtable
endprimitive
  module top;
  endmodule
