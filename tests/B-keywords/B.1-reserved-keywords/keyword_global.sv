/*
:section: Annex B Keywords
:summary: global is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword global is used as a variable name
*/
module top;
  int global;
endmodule
