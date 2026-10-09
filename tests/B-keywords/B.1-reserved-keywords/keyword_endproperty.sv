/*
:section: Annex B Keywords
:summary: endproperty is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword endproperty is used as a variable name
*/
module top;
  int endproperty;
endmodule
