/*
:section: 7.2.2 Assigning to structures
:summary: Members of a packed structure cannot be given default values.
:type: elaboration
:should_fail_because: a packed struct member has a default value
*/
module top;
  typedef struct packed { bit [3:0] a = 4'd2; bit [3:0] b; } p_t;
endmodule
