/*
:section: 29.3.1 UDP header
:summary: A UDP must not declare an inout port; only inputs and a single output are allowed.
:type: parse
:should_fail_because: a UDP port is inout
*/
primitive two_way (y, a);
  output y;
  inout a;
  table
    0 : 1;
  endtable
endprimitive
  module top;
  endmodule
