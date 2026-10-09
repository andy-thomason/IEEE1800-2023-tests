/*
:section: 28.3.3 The delay specification
:summary: A pullup or pulldown instance may not have a delay.
:type: parse
:should_fail_because: a pullup has a delay
*/
module top;
  wire w;
  pullup #3 p(w);
endmodule
