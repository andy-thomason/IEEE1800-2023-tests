/*
:section: 20.10.1 Elaboration severity system tasks
:summary: An elaboration-time $error selected by a generate condition must make elaboration
  fail.
:type: simulation
:should_fail_because: an elaboration-time $error is reached through a generate condition
*/
module checked #(parameter int N = 1);
  if (N > 8) $error("N = %0d is too large", N);
endmodule
module top;
  checked #(.N(9)) u();
  initial $display("PASS");
endmodule
