/*
:section: 6.3.2.1 Charge strength
:summary: Charge strength applies only to trireg nets, with small, medium or large sizes and
  medium by default.
:description: The stored strength is read with the %v format (21.2.1.5).
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic drive = 1'b1, en = 1'b1;
  trireg t_default;
  trireg (small) t_small;
  trireg (large) t_large;
  bufif1 b1(t_default, drive, en);
  bufif1 b2(t_small, drive, en);
  bufif1 b3(t_large, drive, en);
  initial begin
    #1 en = 1'b0;
    #1;
    check($sformatf("%v", t_default) == "Me1", $sformatf("default trireg holds %v, expected Me1", t_default));
    check($sformatf("%v", t_small) == "Sm1", $sformatf("small trireg holds %v, expected Sm1", t_small));
    check($sformatf("%v", t_large) == "La1", $sformatf("large trireg holds %v, expected La1", t_large));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
