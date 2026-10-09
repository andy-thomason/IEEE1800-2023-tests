/*
:section: Annex B Keywords
:summary: const is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword const is used as a variable name
*/
module top;
  int const;
endmodule
