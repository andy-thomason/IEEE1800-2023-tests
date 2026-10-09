/*
:section: 5.10 Structure literals
:summary: An array of structs must not be initialised from a single flat brace list.
:type: elaboration
:should_fail_because: the braces do not reflect the array of structures (C-style flat list)
*/
module top;
  typedef struct { int id; int size; } item_t;
  item_t items [0:1] = '{5, 10, 6, 12};
endmodule
