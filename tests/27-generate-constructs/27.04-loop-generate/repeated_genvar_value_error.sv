/*
:section: 27.4 Loop generate constructs
:summary: A genvar must not repeat a value during loop generate evaluation.
:type: elaboration
:timeout: 60
:should_fail_because: the genvar cycles 0, 1, 0, ...
*/
module top;
  for (genvar g = 0; g < 4; g = (g + 1) % 2) begin : blk
    int v = g;
  end
endmodule
