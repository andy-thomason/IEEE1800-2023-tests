/*
:section: 3.12.1 Compilation units
:summary: A macro defined in one separately compiled unit is invisible to a different
  compilation unit.
:description: Requires one compilation unit per file (Icarus: -u).
:files: directives_do_not_cross_units_probe.svh
:flags-icarus: -u
*/
`define DEFINED_IN_FIRST_UNIT

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  unit_probe u_probe();
  initial begin
    #1;
    check(u_probe.leaked == 0, "a macro from the first unit was visible in the second");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
