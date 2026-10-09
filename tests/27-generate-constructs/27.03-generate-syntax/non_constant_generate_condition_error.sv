/*
:section: 27.3 Generate construct syntax
:summary: The condition of an if-generate must be a constant expression, not a variable.
:type: elaboration
:should_fail_because: an if-generate condition is a variable
*/
module top;
  int runtime = 1;
  if (runtime) begin : blk
    int v;
  end
endmodule
