/*
:section: 9.3.2 Parallel blocks
:summary: Referencing a ref task argument inside fork-join_none is illegal unless it is declared
  ref static.
:type: elaboration
:should_fail_because: a ref argument is used inside fork-join_none
*/
module top;
  task automatic watch(ref int v);
    fork
      #1 v = 2;
    join_none
  endtask
endmodule
