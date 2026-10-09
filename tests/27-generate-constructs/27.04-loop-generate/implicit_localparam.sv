/*
:section: 27.4 Loop generate constructs
:summary: Each loop generate block gets an implicit localparam holding the loop index, reachable
  hierarchically.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  genvar i;
  for (i = 1; i <= 3; i = i + 1) begin : stage
    logic [i-1:0] bus;
    localparam int SQUARE = i * i;
  end
  initial begin
    #1;
    check($bits(stage[1].bus) == 1 && $bits(stage[3].bus) == 3, "the localparam sizes declarations");
    check(stage[2].i == 2 && stage[3].SQUARE == 9, "hierarchical reference to the implicit localparam");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
