/*
:section: 27.5 Conditional generate constructs
:summary: Separate conditional generate constructs in one scope may not reuse a block name.
:type: elaboration
:should_fail_because: two separate conditional generate constructs use the name blk
*/
module top;
  if (1) begin : blk
  end
  if (0) begin : blk
  end
endmodule
