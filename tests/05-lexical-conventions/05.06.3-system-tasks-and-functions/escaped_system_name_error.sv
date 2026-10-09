/*
:section: 5.6.3 System tasks and system functions
:summary: A system task name cannot be written in escaped form like \$display.
:type: elaboration
:should_fail_because: \$display is an escaped user identifier, which is not declared, not a system task
*/
module top;
  initial \$display ("hello");
endmodule
