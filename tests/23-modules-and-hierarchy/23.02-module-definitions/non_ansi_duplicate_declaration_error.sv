/*
:section: 23.2.2.1 Non-ANSI style port declarations
:summary: Declaring the same non-ANSI port twice with port declarations is illegal.
:type: elaboration
:should_fail_because: a port is declared twice
*/
module m(p);
  input p;
  output p;
endmodule
module top;
  wire a;
  m u(a);
endmodule
