/*
:section: 9.3.2 Parallel blocks
:summary: Placing a return statement inside a fork block is a compilation error.
:type: elaboration
:should_fail_because: return is used inside a fork-join block
*/
module top;
  task automatic worker();
    fork
      return;
    join_none
  endtask
endmodule
