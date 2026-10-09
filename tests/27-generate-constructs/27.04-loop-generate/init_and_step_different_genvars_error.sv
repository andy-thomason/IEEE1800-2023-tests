/*
:section: 27.4 Loop generate constructs
:summary: The init and step assignments of a generate loop must target one genvar.
:type: elaboration
:should_fail_because: the iteration assigns a different genvar from the initialization
*/
module top;
  genvar i, j;
  for (i = 0; i < 2; j = j + 1) begin : blk
  end
endmodule
