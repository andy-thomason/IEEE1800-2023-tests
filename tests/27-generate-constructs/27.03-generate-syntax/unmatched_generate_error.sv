/*
:section: 27.3 Generate construct syntax
:summary: A generate keyword without a matching endgenerate is a syntax error.
:type: parse
:should_fail_because: generate has no endgenerate
*/
module top;
  generate
    if (1) begin : blk
      int v;
    end
endmodule
