/*
:section: 6.19.2 Enumerated type ranges
:summary: A name[N] enum range requires N to be a positive count, so zero is illegal.
:type: elaboration
:should_fail_because: N is zero
*/
module top;
  typedef enum {item[0]} e_t;
endmodule
