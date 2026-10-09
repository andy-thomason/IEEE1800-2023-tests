/*
:section: 29.3.1 UDP header
:summary: A UDP may declare only one output; declaring two outputs is illegal.
:type: parse
:should_fail_because: a UDP declares two outputs
*/
primitive two_out (y, z, a);
  output y, z;
  input a;
  table
    0 : 1;
  endtable
endprimitive
  module top;
  endmodule
