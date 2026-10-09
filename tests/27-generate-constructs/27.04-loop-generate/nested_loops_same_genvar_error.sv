/*
:section: 27.4 Loop generate constructs
:summary: An inner generate loop may not reuse the genvar of its enclosing generate loop.
:type: elaboration
:should_fail_because: nested loops share the genvar i
*/
module top;
  genvar i;
  for (i = 0; i < 2; i = i + 1) begin : outer
    for (i = 0; i < 2; i = i + 1) begin : inner
    end
  end
endmodule
