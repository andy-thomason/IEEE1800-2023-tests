/*
:section: 3.12.1 Compilation units
:summary: With one compilation unit per file, each file may declare its own same-named
  unit-scope parameter independently.
:description: Both files declare UNIT_ID in their own compilation-unit scope. With one compilation
  unit per file this is legal and each file sees its own value. Icarus selects this mode
  with -u; a tool with no such mode reports a redeclaration.
:files: separate_units_private_declarations_helper.svh
:flags-icarus: -u
*/
parameter int UNIT_ID = 1;

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  unit_helper u_helper();
  initial begin
    #1;
    check(UNIT_ID == 1, $sformatf("UNIT_ID in the first file = %0d", UNIT_ID));
    check(u_helper.seen == 2, $sformatf("UNIT_ID in the second file = %0d", u_helper.seen));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
