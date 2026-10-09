/*
:section: 29.3.4 UDP state table
:summary: Edge symbols such as r are illegal in a combinational UDP table.
:type: parse
:should_fail_because: an edge appears in a combinational UDP
*/
primitive comb_edge (y, a);
  output y;
  input a;
  table
    r : 1;
  endtable
endprimitive
  module top;
  endmodule
