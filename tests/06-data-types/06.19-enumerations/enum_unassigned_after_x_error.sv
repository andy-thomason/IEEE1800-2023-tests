/*
:section: 6.19 Enumerations
:summary: An enum name without a value must not follow a name assigned x or z.
:type: elaboration
:should_fail_because: C has no value and follows an x-valued name
*/
module top;
  typedef enum logic [1:0] {A = 0, B = 'x, C} e_t;
endmodule
