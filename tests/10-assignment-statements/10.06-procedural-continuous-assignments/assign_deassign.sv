/*
:section: 10.6.1 The assign and deassign procedural statements
:summary: Procedural assign overrides other procedural writes, and after deassign the variable
  keeps its value until reassigned.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] q;
  logic [3:0] a = 4'd1, b = 4'd2;
  initial begin
    assign q = a;
    q = 4'd9;
    #1 check(q == 1, "procedural assignment overrode an assign");
    assign q = b;
    b = 4'd7;
    #1 check(q == 7, "the second assign did not replace the first");
    deassign q;
    b = 4'd3;
    #1 check(q == 7, "the value did not hold after deassign");
    q = 4'd5;
    check(q == 5, "procedural assignment after deassign");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
