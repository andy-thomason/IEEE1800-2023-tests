/*
:section: 28.15.2 trireg strength
:summary: trireg retains its last driven value with medium default charge strength, ignoring z
  from drivers.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic d, en;
  trireg c_default;
  trireg (small) c_small;
  trireg (large) c_large;
  bufif1 b1(c_default, d, en);
  bufif1 b2(c_small, d, en);
  bufif1 b3(c_large, d, en);
  initial begin
    d = 1; en = 1;
    #1;
    check($sformatf("%v", c_default) == "St1", "driven trireg has the driver's strength");
    en = 0;
    #1;
    check($sformatf("%v", c_default) == "Me1", $sformatf("default charge strength: %v", c_default));
    check($sformatf("%v", c_small) == "Sm1" && $sformatf("%v", c_large) == "La1", $sformatf("small/large: %v %v", c_small, c_large));
    d = 0; en = 1; #1; en = 0; #1;
    check(c_default === 1'b0, "retains 0 after the driver turns off");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
