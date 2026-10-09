/*
:section: 13.5.3 Default argument values
:summary: Omitting an argument that has no default value in a call is an error.
:type: elaboration
:should_fail_because: an argument without a default is omitted
*/
module top;
  function int need(int k, int j = 1); return k + j; endfunction
  int r;
  initial r = need();
endmodule
