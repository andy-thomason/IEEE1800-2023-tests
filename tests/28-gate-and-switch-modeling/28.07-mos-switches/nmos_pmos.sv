/*
:section: 28.7 MOS switches
:summary: nmos conducts when control is 1 and pmos conducts when control is 0.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic d, c;
  wire n, p;
  nmos m1(n, d, c);
  pmos m2(p, d, c);
  initial begin
    d = 1; c = 1; #1;
    check(n === 1 && p === 1'bz, "control 1: nmos on, pmos off");
    c = 0; #1;
    check(n === 1'bz && p === 1, "control 0: nmos off, pmos on");
    d = 1'bz; #1;
    check(p === 1'bz, "an on switch passes z");
    check($sformatf("%v", n) == "HiZ", "off nmos is high impedance");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
