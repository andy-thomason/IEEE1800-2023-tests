/*
:section: 6.21 Scope and lifetime
:summary: A for loop variable is automatic, so nonblocking assignment to it is illegal.
:type: elaboration
:should_fail_because: a for-loop variable is automatic even in a static module, so it cannot take a
  nonblocking assignment
*/
module static top;
  initial
for (int i = 0; i < 2; i++) i <= 5;
endmodule
