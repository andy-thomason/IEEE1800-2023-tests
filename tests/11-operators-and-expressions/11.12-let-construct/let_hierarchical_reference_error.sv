/*
:section: 11.12 Let construct
:summary: A let declaration may not be referenced through a hierarchical path.
:type: elaboration
:should_fail_because: a let declaration is referenced hierarchically
*/
module top;
  module inner;
    let twice(x) = 2 * x;
  endmodule
  inner u();
  int r;
  initial r = u.twice(3);
endmodule
