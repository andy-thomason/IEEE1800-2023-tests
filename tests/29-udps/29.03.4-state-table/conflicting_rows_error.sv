/*
:section: 29.3.4 UDP state table
:summary: Two UDP table rows matching the same input combination with different outputs are
  illegal.
:type: elaboration
:should_fail_because: inputs 1 0 match rows with outputs 1 and 0
*/
primitive clash (y, a, b);
  output y;
  input a, b;
  table
    1 ? : 1;
    ? 0 : 0;
  endtable
endprimitive
  module top;
  endmodule
