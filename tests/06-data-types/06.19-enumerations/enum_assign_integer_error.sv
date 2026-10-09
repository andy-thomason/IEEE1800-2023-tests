/*
:section: 6.19.3 Type checking
:summary: Assigning a plain integer literal to an enum variable without a cast is illegal.
:type: elaboration
:should_fail_because: an integer is assigned to an enum variable without a cast
*/
module top;
  typedef enum {RED, GREEN, BLUE} colour_t;
  typedef enum {MON, TUE, WED} day_t;
  colour_t c = RED;
  day_t w = TUE;
  initial c = 1;
endmodule
