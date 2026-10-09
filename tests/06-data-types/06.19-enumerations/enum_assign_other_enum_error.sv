/*
:section: 6.19.3 Type checking
:summary: Assigning a value of one enum type to a variable of another enum type needs a cast.
:type: elaboration
:should_fail_because: a value of a different enum type is assigned without a cast
*/
module top;
  typedef enum {RED, GREEN, BLUE} colour_t;
  typedef enum {MON, TUE, WED} day_t;
  colour_t c = RED;
  day_t w = TUE;
  initial c = w;
endmodule
