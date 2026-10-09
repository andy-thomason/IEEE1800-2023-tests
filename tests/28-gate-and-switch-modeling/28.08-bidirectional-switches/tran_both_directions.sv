/*
:section: 28.8 Bidirectional pass switches
:summary: tran conducts both ways with no delay between its two terminals.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic da = 1'bz, db = 1'bz;
  wire a, b;
  assign a = da;
  assign b = db;
  tran t(a, b);
  initial begin
    da = 1; #0 #0;
    #1 check(b === 1'b1, "a drives b");
    da = 1'bz; db = 0;
    #1 check(a === 1'b0, "b drives a");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
