/*
:section: 9.7 Fine-grain process control
:summary: Creating a process object with new is an error.
:type: elaboration
:should_fail_because: new is called for the process class
*/
module top;
  process p;
  initial p = new;
endmodule
