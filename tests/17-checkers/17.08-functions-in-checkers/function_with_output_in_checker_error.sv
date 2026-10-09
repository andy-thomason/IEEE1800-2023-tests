/*
:section: 17.8 Functions in checkers
:summary: A function called in a checker expression must not have output arguments.
:type: elaboration
:should_fail_because: a function with an output argument is used in a checker expression
*/
checker fn_chk (logic [3:0] v, event clock);
  function automatic bit split(input logic [3:0] x, output logic hi);
    hi = x[3];
    return x[0];
  endfunction
  logic h;
  a1: assert property (@(clock) split(v, h));
endchecker
module top;
  logic clk;
  logic [3:0] v;
  fn_chk u(v, posedge clk);
endmodule
