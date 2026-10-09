/*
:section: 29.3.4 UDP state table
:summary: A table row whose inputs are all x must not produce a known output value such as 1.
:type: elaboration
:should_fail_because: a row with all inputs x has output 1
*/
primitive x_to_one (y, a, b);
  output y;
  input a, b;
  table
    x x : 1;
  endtable
endprimitive
  module top;
  endmodule
