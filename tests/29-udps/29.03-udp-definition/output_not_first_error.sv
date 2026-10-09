/*
:section: 29.3.1 UDP header
:summary: In a UDP header the output must be listed before every input in the port list.
:type: elaboration
:should_fail_because: the output is the second port
*/
primitive backwards (a, y);
  output y;
  input a;
  table
    0 : 1;
    1 : 0;
  endtable
endprimitive
  module top;
  endmodule
