/*
:section: 6.21 Scope and lifetime
:summary: A continuous assignment must not drive a non-static class property.
:type: elaboration
:should_fail_because: a class property is written with a continuous assignment
*/
  module static top;
    class c_t; int p; endclass
c_t h = new;
assign h.p = 1;
  endmodule
