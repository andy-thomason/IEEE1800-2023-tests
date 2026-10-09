/*
:section: 28.13 Strength reduction by nonresistive devices
:summary: MOS switches lower supply strength to strong; resistive switches reduce strengths
  further per table.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  supply1 vdd;
  logic on = 1;
  wire pulled;
  pullup pu(pulled);
  wire o_supply, o_pull, r_strong, r_pull, r_supply;
  logic strong_one = 1;
  nmos n1(o_supply, vdd, on);
  nmos n2(o_pull, pulled, on);
  rnmos r1(r_strong, strong_one, on);
  rnmos r2(r_pull, pulled, on);
  rpmos r3(r_supply, vdd, !on);
  initial begin
    #1;
    check($sformatf("%v", o_supply) == "St1", $sformatf("supply reduced to strong by nmos: %v", o_supply));
    check($sformatf("%v", o_pull) == "Pu1", $sformatf("nmos keeps pull: %v", o_pull));
    check($sformatf("%v", r_strong) == "Pu1", $sformatf("rnmos strong -> pull: %v", r_strong));
    check($sformatf("%v", r_pull) == "We1", $sformatf("rnmos pull -> weak: %v", r_pull));
    check($sformatf("%v", r_supply) == "Pu1", $sformatf("rpmos supply -> pull: %v", r_supply));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
