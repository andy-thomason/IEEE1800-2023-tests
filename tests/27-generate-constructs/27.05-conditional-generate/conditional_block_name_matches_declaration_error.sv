/*
:section: 27.5 Conditional generate constructs
:summary: A conditional generate block name must not match another declaration, even if not
  selected.
:type: elaboration
:should_fail_because: an unselected generate block has the same name as a variable
*/
module top;
  int blk;
  if (0) begin : blk
  end
endmodule
