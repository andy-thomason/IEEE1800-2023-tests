/*
:section: 27.4 Loop generate constructs
:summary: The initial assignment of a generate loop may not read the loop genvar itself.
:type: elaboration
:should_fail_because: the initialization reads the loop index
*/
module top;
  genvar i;
  for (i = i + 1; i < 2; i = i + 1) begin : blk
  end
endmodule
