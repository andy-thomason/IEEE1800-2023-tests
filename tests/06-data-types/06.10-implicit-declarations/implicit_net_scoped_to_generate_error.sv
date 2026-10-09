/*
:section: 6.10 Implicit declarations
:summary: An implicit net created inside a generate block is not visible outside that block.
:type: elaboration
:should_fail_because: inside_only is declared only in the generate block
*/
module top;
  if (1) begin : g
    assign inside_only = 1'b1;
  end
  logic copy;
  initial copy = inside_only;
endmodule
