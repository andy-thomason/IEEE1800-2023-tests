/*
:section: 4.9.2 Procedural continuous assignment
:summary: Procedural assign and force keep their target updated whenever the source expression
  changes.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [7:0] src = 8'd1;
  logic [7:0] held;
  logic a = 0, b = 1;
  wire w = a | b;
  initial begin
    #1 assign held = src + 8'd1;
    #1 check(held == 2, $sformatf("assign: held = %0d", held));
    src = 8'd10;
    #1 check(held == 11, $sformatf("assign did not follow its source: held = %0d", held));
    deassign held;
    src = 8'd20;
    #1 check(held == 11, $sformatf("deassign did not stop the assignment: held = %0d", held));
    force w = a & b;
    #1 check(w === 1'b0, "force did not override the net");
    a = 1;
    #1 check(w === 1'b1, "force did not follow its source");
    release w;
    b = 0;
    #1 check(w === 1'b1, "release did not return the net to its driver (a | b)");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
