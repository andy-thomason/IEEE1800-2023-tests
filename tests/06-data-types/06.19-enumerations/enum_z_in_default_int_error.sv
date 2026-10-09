/*
:section: 6.19 Enumerations
:summary: An enum with the default int base type must not assign a z value.
:type: elaboration
:should_fail_because: the default int enum has a z value
*/
module top;
  typedef enum {A, B = 'z} e_t;
endmodule
