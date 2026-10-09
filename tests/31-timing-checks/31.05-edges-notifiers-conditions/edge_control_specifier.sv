/*
:section: 31.5 Edge-control specifiers
:summary: An edge[01] specifier restricts a timing check to the listed bit transitions only.
:flags-icarus: -gspecify
*/
module chk(input clk, input d);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $hold(edge[01] clk, d, 5, n);
  endspecify
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic clk, d = 0;
  chk u(.clk(clk), .d(d));
  initial begin
    #100 clk = 1;    // x->1 is not an edge[01] event
    #2 d = 1;
    #8 clk = 0;
    #90 clk = 1;     // 0->1
    #2 d = 0;        // violation
    #10;
    check(u.violations == 1, $sformatf("expected 1 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
