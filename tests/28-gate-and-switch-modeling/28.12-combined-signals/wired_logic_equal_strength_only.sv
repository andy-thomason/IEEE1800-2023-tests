/*
:section: 28.12.4 Wired logic net types
:summary: Wired net types like wand, wor and triand resolve equal-strength drivers with logic
  functions.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  triand ta;
  wor wo;
  wand wa;
  assign ta = 1'b1;
  assign ta = 1'b0;
  assign wo = 1'b1;
  assign wo = 1'b0;
  assign (pull1, pull0) wa = 1'b0;
  assign wa = 1'b1;
  initial begin
    #1;
    check(ta === 1'b0 && wo === 1'b1, "equal-strength conflicts resolved as and/or");
    check($sformatf("%v", wa) == "St1", $sformatf("unequal strengths on a wand: the stronger wins: %v", wa));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
