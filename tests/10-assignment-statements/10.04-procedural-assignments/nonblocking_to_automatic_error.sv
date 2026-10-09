/*
:section: 10.4.2 Nonblocking procedural assignments
:summary: A nonblocking assignment to an automatic variable is illegal.
:type: elaboration
:should_fail_because: a nonblocking assignment targets an automatic variable
*/
module top;
  initial begin
    automatic int k;
    k <= 1;
  end
endmodule
