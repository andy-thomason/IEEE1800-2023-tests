/*
:section: 6.21 Scope and lifetime
:summary: A nonblocking assignment to an automatic variable is illegal.
:type: elaboration
:should_fail_because: an automatic variable is written with a nonblocking assignment
*/
  module static top;
    task automatic t();
  int a;
  a <= 1;
endtask
  endmodule
