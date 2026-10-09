/*
:section: 6.19 Enumerations
:summary: Two enum names must not share the same value, whether given explicitly or by
  auto-increment.
:type: elaboration
:should_fail_because: Q (automatically 3) and R both have the value 3
*/
module top;
  typedef enum {P = 2, Q, R = 3} e_t;
endmodule
