/*
:section: 23.3.2 Module instantiation syntax
:summary: One instantiation must not mix positional and named port connections.
:type: parse
:should_fail_because: ordered and named port connections are mixed
*/
module m(input a, b); endmodule
module top;
  wire x, y;
  m u(x, .b(y));
endmodule
