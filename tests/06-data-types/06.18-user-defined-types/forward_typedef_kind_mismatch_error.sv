/*
:section: 6.18 User-defined types
:summary: A forward typedef naming struct must not be completed by an enum definition.
:type: elaboration
:should_fail_because: the forward declaration says struct but the definition is an enum
*/
module top;
  typedef struct shape_t;
  typedef enum {SQUARE, CIRCLE} shape_t;
endmodule
