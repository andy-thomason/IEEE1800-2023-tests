/*
:section: 6.21 Scope and lifetime
:summary: An automatic variable may not be the target of a procedural continuous assign.
:type: elaboration
:should_fail_because: an automatic variable is written with a procedural continuous assignment
*/
  module static top;
    task automatic t();
  int a;
  assign a = 1;
endtask
  endmodule
