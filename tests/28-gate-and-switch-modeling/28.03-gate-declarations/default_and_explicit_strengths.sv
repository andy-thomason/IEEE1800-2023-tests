/*
:section: 28.3.2 The drive strength specification
:summary: Gates default to strong1/strong0 drive, and explicit strength1 and strength0 settings
  override this.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic a = 1, b = 1;
  wire o_default, o_set;
  and g1(o_default, a, b);
  or (pull1, weak0) g2(o_set, a, b);
  initial begin
    #1;
    check($sformatf("%v", o_default) == "St1", $sformatf("default strength %v", o_default));
    check($sformatf("%v", o_set) == "Pu1", $sformatf("pull1 output %v", o_set));
    a = 0; b = 0;
    #1;
    check($sformatf("%v", o_default) == "St0", $sformatf("default strength %v", o_default));
    check($sformatf("%v", o_set) == "We0", $sformatf("weak0 output %v", o_set));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
