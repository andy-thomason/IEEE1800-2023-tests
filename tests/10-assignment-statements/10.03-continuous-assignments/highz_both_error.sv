/*
:section: 10.3.4 Continuous assignment strengths
:summary: Specifying highz for both the 1 and 0 drive strengths is illegal.
:type: parse
:should_fail_because: both strengths are highz
*/
module top;
  wire w;
  assign (highz1, highz0) w = 1'b1;
endmodule
