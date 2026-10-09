/*
:section: 6.22 Type compatibility
:summary: Unpacked struct types declared inside different instances are distinct and cannot be
  assigned.
:type: elaboration
:should_fail_because: each instance's unpacked struct type is unique, so the two are not equivalent
*/
module holder;
  typedef struct { int r; } local_t;
  local_t v;
endmodule

module top;
  holder h1();
  holder h2();
  initial h2.v = h1.v;
endmodule
