/*
:section: Annex B Keywords
:summary: while is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword while is used as a variable name
*/
module top;
  int while;
endmodule
