/*
:section: Annex B Keywords
:summary: endtask is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword endtask is used as a variable name
*/
module top;
  int endtask;
endmodule
