/*
:section: 9.7 Fine-grain process control
:summary: Deriving a user class from the built-in process class is a compilation error.
:type: elaboration
:should_fail_because: the process class is extended
*/
module top;
  class my_process extends process; endclass
endmodule
