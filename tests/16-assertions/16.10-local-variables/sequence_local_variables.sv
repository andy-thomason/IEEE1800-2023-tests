/*
:section: 16.10 Local variables
:summary: A sequence can capture a value into a local variable in a match item and use it later.
:flags-verilator: --coverage-user
*/
module top;
  timeunit 1ns; timeprecision 1ns;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic clk = 0;
  always #5 clk = ~clk;
  logic a = 0;
  int data = 0, out = 0, fails = 0, passes = 0;
  int cyc = 0;
  always @(negedge clk) begin
    cyc <= cyc + 1;
    data <= cyc + 1;
    a <= (cyc + 1 == 1) || (cyc + 1 == 4);
    out <= (cyc + 1 == 6) ? 99 : cyc;
  end
  property p_track;
    int v;
    (a, v = data) |-> ##2 (out == v + 1);
  endproperty
  ap: assert property (@(posedge clk) p_track) else fails++;
  initial begin
    #120;
    check(fails == 1, $sformatf("%0d failures, expected 1 (the attempt at cycle 4 sees out = 99)", fails));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
