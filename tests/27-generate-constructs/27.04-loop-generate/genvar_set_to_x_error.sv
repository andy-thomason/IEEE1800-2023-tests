/*
:section: 27.4 Loop generate constructs
:summary: A genvar may not take an x or z value while a generate loop is evaluated.
:type: elaboration
:timeout: 60
:should_fail_because: the iteration assigns x to the genvar
*/
module top;
  for (genvar g = 0; g < 4; g = 'x) begin : blk
    int v = g;
  end
endmodule
