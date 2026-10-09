/*
:section: 6.19 Enumerations
:summary: Two names in one enumeration must not be identical.
:type: elaboration
:should_fail_because: the name P is used twice
*/
module top;
  typedef enum {P, Q, P} e_t;
endmodule
