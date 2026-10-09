/*
:section: Annex B Keywords
:summary: endprimitive is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword endprimitive is used as a variable name
*/
module top;
  int endprimitive;
endmodule
