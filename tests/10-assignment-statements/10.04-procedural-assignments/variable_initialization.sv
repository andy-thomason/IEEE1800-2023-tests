/*
:section: 10.5 Variable declaration assignment (variable initialization)
:summary: An initializer on a variable declaration sets a starting value once rather than
  creating a continuous assignment.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] src = 4'd3;
  logic [3:0] snap = src + 4'd1;
  wire [3:0] live = src + 4'd1;
  initial begin
    src = 4'd9;
    #1;
    check(snap == 4, "a variable initialiser behaved like a continuous assignment");
    check(live == 10, "a net declaration assignment is continuous");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
