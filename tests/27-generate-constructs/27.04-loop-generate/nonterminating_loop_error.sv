/*
:section: 27.4 Loop generate constructs
:summary: A loop generate scheme that never terminates is an error.
:type: elaboration
:timeout: 60
:should_fail_because: the loop condition never becomes false
*/
module top;
  for (genvar g = 0; g >= 0; g = g + 0) begin : forever_blk
    int v = g;
  end
endmodule
