/*
:section: 29.3.5 z values in UDP
:summary: Using z as a symbol inside a UDP table row is illegal.
:type: parse
:should_fail_because: a table entry uses z
*/
primitive with_z (y, a);
  output y;
  input a;
  table
    z : 1;
  endtable
endprimitive
  module top;
  endmodule
