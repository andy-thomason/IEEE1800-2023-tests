/*
:section: 7.2 Structures
:summary: The rand qualifier is not allowed on members of a packed structure.
:type: parse
:should_fail_because: rand is used in a packed struct
*/
module top;
  typedef struct packed { rand bit [3:0] a; bit [3:0] b; } p_t;
endmodule
