/*
:section: 27.3 Generate construct syntax
:summary: A generate region may not be placed inside another generate region.
:type: parse
:should_fail_because: a generate region is nested inside a generate block
*/
module top;
  generate
    if (1) begin : blk
      generate
        int v;
      endgenerate
    end
  endgenerate
endmodule
