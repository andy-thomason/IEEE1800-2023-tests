/*
:section: 23.3.3.2 Port connection rules for variables
:summary: A ref port must always be connected and cannot be left unconnected.
:type: elaboration
:should_fail_because: a ref port is left unconnected
*/
module m(ref int r); endmodule
module top;
  m u(.r());
endmodule
