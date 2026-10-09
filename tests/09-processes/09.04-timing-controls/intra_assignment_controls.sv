/*
:section: 9.4.5 Intra-assignment timing controls
:summary: Intra-assignment delays evaluate the right-hand side immediately but defer the update,
  including repeat event forms.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic clk = 0;
  int a = 1, b, c, d;
  int n = -1;
  always #1 clk = ~clk;
  initial #2 a = 50;
  initial begin
    b = repeat (3) @(posedge clk) a;
    check(b == 1 && $time == 5, $sformatf("repeat(3)@ gave b=%0d at %0t", b, $time));
    c = @(negedge clk) a;
    check(c == 50 && $time == 6, "intra-assignment event control");
    d = repeat (n) @(posedge clk) 7;
    check(d == 7 && $time == 6, "repeat count <= 0 did not assign immediately");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
