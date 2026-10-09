/*
:section: 22.6 `ifdef, `else, `elsif, `endif, `ifndef
:summary: Text skipped by conditional compilation must still be lexically valid, so an
  unterminated string is an error.
:type: parse
:should_fail_because: an ignored block contains an unterminated string literal
*/
module top;
`ifdef NOT_DEFINED_ANYWHERE
  string s = "unterminated;
`endif
endmodule
