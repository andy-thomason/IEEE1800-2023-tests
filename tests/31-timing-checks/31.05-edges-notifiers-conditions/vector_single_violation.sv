/*
:section: 31.8 Vector signals in timing checks
:summary: A timing check on a vector treats simultaneous changes of several bits as one
  transition.
:flags-icarus: -gspecify
*/
module chk(input clk, input [7:0] dat);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $setup(dat, posedge clk, 10, n);
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
  logic clk = 0;
  logic [7:0] dat = 8'h2E;
  chk u(.clk(clk), .dat(dat));
  initial begin
    #100 dat = 8'h53;  // six bits change at once
    #5 clk = 1;
    #10;
    check(u.violations == 1, $sformatf("expected 1 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
