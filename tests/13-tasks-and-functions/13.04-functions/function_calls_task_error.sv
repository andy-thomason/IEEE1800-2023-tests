/*
:section: 13.4 Functions
:summary: A function may not call a task.
:type: elaboration
:should_fail_because: a function enables a task
*/
module top;
  task quick(); endtask
  function int f();
    quick();
    return 1;
  endfunction
endmodule
