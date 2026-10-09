/*
:section: 29.6 Edge-sensitive sequential UDPs
:summary: A sequential UDP table row may contain an edge on only one input.
:type: parse
:should_fail_because: a row has edges on two inputs
*/
primitive two_edges (q, a, b);
  output q;
  reg q;
  input a, b;
  table
    r r : ? : 1;
  endtable
endprimitive
  module top;
  endmodule
