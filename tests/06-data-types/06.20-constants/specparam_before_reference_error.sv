/*
:section: 6.20.5 Specify parameters
:summary: A specparam declared in the module body cannot be used before its declaration.
:type: elaboration
:should_fail_because: the specparam is referenced before its declaration
*/
module top;
  int v;
  initial v = LATE;
  specparam LATE = 5;
endmodule
