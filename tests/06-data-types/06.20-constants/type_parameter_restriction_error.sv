/*
:section: 6.20.3 Type parameters
:summary: Giving a struct type to an enum-restricted type parameter is illegal.
:type: elaboration
:should_fail_because: a struct type is given to a type parameter restricted to enum
*/
typedef enum {OFF, ON} switch_t;
typedef struct { int x; } point_t;

module only_enum #(parameter type enum E = switch_t);
  E value;
endmodule

module top;
  only_enum #(.E(point_t)) u();
endmodule
