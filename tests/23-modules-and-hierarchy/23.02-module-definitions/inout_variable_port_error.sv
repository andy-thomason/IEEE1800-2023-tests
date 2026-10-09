/*
:section: 23.2.2.3 Rules for determining port kind, data type, and direction
:summary: A var first port without a direction becomes inout, and an inout variable port is
  illegal.
:type: elaboration
:should_fail_because: the first port defaults to inout, which cannot be a variable
*/
module m(var logic x);
endmodule
module top;
endmodule
