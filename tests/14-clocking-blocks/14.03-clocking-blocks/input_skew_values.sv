/*
:section: 14.4 Input and output skews
:summary: Input skews may be parameters, sampling the signal that many time units before the
  clocking event.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  timeunit 1ns; timeprecision 1ns;
  logic clk = 0;
  always #5 clk = ~clk;
  logic [7:0] sig = 0;
  parameter int SKEW = 2;
  clocking early @(posedge clk);
    input #SKEW sig;
  endclocking
  clocking zero @(posedge clk);
    input #0 sig;
  endclocking
  clocking unit_skew @(posedge clk);
    input #3ns sig;
  endclocking
  initial begin
    #2 sig = 10;   // t=2
    #2 sig = 20;   // t=4, one unit before the edge at 5
    #1 sig = 30;   // t=5, at the edge
  end
  initial begin
    @(posedge clk);
    #1;
    check(early.sig == 10, $sformatf("#2 skew sampled %0d at t=3, expected 10", early.sig));
    check(unit_skew.sig == 10, $sformatf("#3ns skew sampled %0d at t=2, expected 10", unit_skew.sig));
    check(zero.sig == 30, $sformatf("#0 skew sampled %0d, expected the value at the edge", zero.sig));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
