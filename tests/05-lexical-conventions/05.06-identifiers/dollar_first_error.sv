/*
:section: 5.6 Identifiers, keywords, and system names
:summary: A simple identifier must not start with a dollar sign.
:type: parse
:should_fail_because: a simple identifier cannot start with $
*/
module top;
  int $counter;
endmodule
