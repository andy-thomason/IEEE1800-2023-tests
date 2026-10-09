/*
:section: 35.7 Exported functions
:summary: A task must be exported with the task keyword, not the function keyword.
:type: elaboration
:should_fail_because: a task is exported with the function keyword
*/
module top;
  export "DPI-C" function really_a_task;
  task really_a_task(); endtask
endmodule
