/*
:section: 6.3.2 Strengths
:summary: Drive strength on a net declaration is illegal unless the declaration also assigns the
  net.
:type: parse
:should_fail_because: a drive strength is given on a net declaration without an assignment
*/
module top;
  wire (strong0, weak1) w;
endmodule
