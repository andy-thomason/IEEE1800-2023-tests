/*
:section: 27.2 Overview
:summary: A parameter declared in a generate block is a localparam and cannot be changed by
  defparam.
:type: elaboration
:should_fail_because: a defparam overrides a parameter that is a localparam because it is in a generate
  block
*/
module leaf;
  if (1) begin : blk
    parameter int P = 1;
  end
endmodule
module top;
  leaf u();
  defparam u.blk.P = 2;
endmodule
