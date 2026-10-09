/*
:section: G.6 Process
:summary: Because std::process is declared final, extending it is illegal.
:type: elaboration
:should_fail_because: a class extends the final class process
*/
module top;
  class my_process extends std::process;
  endclass
endmodule
