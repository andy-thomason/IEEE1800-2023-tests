/*
:section: 28.9 CMOS switches
:summary: cmos and rcmos take output, data, n-control, p-control and conduct when either channel
  is on.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic d = 1, nc, pc;
  wire y, ry;
  cmos c(y, d, nc, pc);
  rcmos r(ry, d, nc, pc);
  initial begin
    nc = 1; pc = 1; #1;
    check(y === 1'b1, "n-channel on");
    nc = 0; pc = 0; #1;
    check(y === 1'b1, "p-channel on");
    nc = 0; pc = 1; #1;
    check(y === 1'bz, "both channels off");
    nc = 1; pc = 0; #1;
    check($sformatf("%v", y) == "St1", $sformatf("both on: %v", y));
    check($sformatf("%v", ry) == "Pu1", $sformatf("rcmos reduces strong to pull: %v", ry));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
