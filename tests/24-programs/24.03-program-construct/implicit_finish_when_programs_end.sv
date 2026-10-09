/*
:section: 24.3 The program construct
:summary: Simulation ends automatically via an implicit $finish once all program initial threads
  complete.
:timeout: 30
:description: The free-running clock never stops, so the run ends only through the implicit $finish.
*/
module top;
  logic clk = 0;
  always #1 clk = ~clk;
  tb t(.clk(clk));
endmodule

program tb(input logic clk);
  initial begin
    repeat (3) @(posedge clk);
    $display("PASS");
  end
endprogram
