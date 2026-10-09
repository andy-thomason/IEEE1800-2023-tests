/*
:section: 6.21 Scope and lifetime
:summary: An element of a dynamic array cannot be written by nonblocking assignment.
:type: elaboration
:should_fail_because: an element of a dynamic array is written with a nonblocking assignment
*/
  module static top;
    int d [];
initial begin
  d = new [2];
  d[0] <= 1;
end
  endmodule
