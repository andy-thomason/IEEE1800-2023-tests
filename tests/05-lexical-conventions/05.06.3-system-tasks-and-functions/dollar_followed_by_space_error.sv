/*
:section: 5.6.3 System tasks and system functions
:summary: A system task name must not have white space after its leading $.
:type: parse
:should_fail_because: the $ is separated from the system task name by a space
*/
module top;
  initial $ display("hello");
endmodule
