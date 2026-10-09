/*
:section: 5.6 Identifiers, keywords, and system names
:summary: A simple identifier must not start with a digit.
:type: parse
:should_fail_because: 2fast begins with a digit, so it is not an identifier
*/
module top;
  logic 2fast;
endmodule
