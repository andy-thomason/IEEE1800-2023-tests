/*
:section: 6.19.3 Type checking
:summary: Applying ++ to an enum variable is illegal because it assigns an int result.
:type: elaboration
:should_fail_because: ++ assigns an int expression to an enum variable
*/
module top;
  typedef enum {RED, GREEN, BLUE} colour_t;
  typedef enum {MON, TUE, WED} day_t;
  colour_t c = RED;
  day_t w = TUE;
  initial c++;
endmodule
