/*
:section: 26.3 Referencing data in packages
:summary: A wildcard import only resolves a reference if it appears before that reference in the
  scope.
*/
package early; function automatic int f(); return 1; endfunction endpackage
package late;  function automatic int f(); return 2; endfunction endpackage

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import early::*;
  int got;
  initial begin : blk
    got = f();
  end
  import late::*;
  initial begin
    #1;
    check(got == 1, $sformatf("f bound to %0d; only the import before the reference counts", got));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
