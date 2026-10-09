/*
:section: 23.2.2.2 ANSI style list of port declarations
:summary: Mixing ANSI port declarations in the header with non-ANSI declarations in the body is
  illegal.
:type: parse
:should_fail_because: ANSI and non-ANSI port declarations are mixed
*/
module m(input a, b);
  output b;
endmodule
module top;
endmodule
