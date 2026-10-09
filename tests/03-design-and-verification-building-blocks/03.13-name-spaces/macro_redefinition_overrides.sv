/*
:section: 3.13 Name spaces
:summary: Redefining a text macro replaces the earlier definition for subsequent text; macro
  names never clash with variables.
:description: Also checks that a variable may share a name with a macro.
*/
`define LANES 4

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int LANES = 100;
  int before_redefine = `LANES;
`define LANES 8
  int after_redefine = `LANES;
  initial begin
    check(before_redefine == 4, $sformatf("first definition gave %0d", before_redefine));
    check(after_redefine == 8, $sformatf("redefinition gave %0d", after_redefine));
    check(LANES == 100, $sformatf("variable LANES = %0d", LANES));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
