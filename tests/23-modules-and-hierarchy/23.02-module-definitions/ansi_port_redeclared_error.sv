/*
:section: 23.2.2.2 ANSI style list of port declarations
:summary: Declaring an ANSI-style port again inside the module body is illegal.
:type: elaboration
:should_fail_because: an ANSI port is redeclared in the body
*/
module m(input logic [3:0] a);
  wire [3:0] a;
endmodule
module top;
endmodule
