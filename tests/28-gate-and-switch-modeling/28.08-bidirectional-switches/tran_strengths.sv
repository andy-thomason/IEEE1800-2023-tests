/*
:section: 28.13 Strength reduction by nonresistive devices
:summary: tran keeps signal strength except supply becomes strong, while rtran reduces strong to
  pull.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  supply0 gnd;
  wire t_supply, pulled, t_pull, r_out;
  logic strong_zero = 0;
  wire s;
  assign s = strong_zero;
  pulldown pd(pulled);
  tran t1(gnd, t_supply);
  tranif1 t2(pulled, t_pull, 1'b1);
  rtran r1(s, r_out);
  initial begin
    #1;
    check($sformatf("%v", t_supply) == "St0", $sformatf("supply through tran: %v", t_supply));
    check($sformatf("%v", t_pull) == "Pu0", $sformatf("pull through tranif1: %v", t_pull));
    check($sformatf("%v", r_out) == "Pu0", $sformatf("strong through rtran: %v", r_out));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
