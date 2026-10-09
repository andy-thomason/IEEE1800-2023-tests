/*
:section: 27.2 Overview
:summary: Port declarations are not permitted inside a generate block.
:type: parse
:should_fail_because: a port is declared inside a generate block
*/
module leaf(a);
  if (1) begin : blk
    input a;
  end
endmodule
module top;
  wire w;
  leaf u(w);
endmodule
