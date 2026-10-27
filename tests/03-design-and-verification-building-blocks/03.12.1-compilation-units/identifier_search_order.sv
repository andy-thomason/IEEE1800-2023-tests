/*
:section: 3.12.1 Compilation units
:summary: Name lookup checks local nested scopes first, then earlier compilation-unit
  declarations, before outer instance scopes.
*/
int level = 1;
int unit_only = 5;

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int level = 2;
  function automatic int read_level();
    return level;
  endfunction
  initial begin : outer
    int inner_seen;
    begin : inner
      static int level = 3;
      inner_seen = level;
    end
    check(inner_seen == 3, $sformatf("innermost block saw level = %0d", inner_seen));
    check(level == 2, $sformatf("module scope saw level = %0d", level));
    check(read_level() == 2, $sformatf("function saw level = %0d", read_level()));
    check(unit_only == 5, $sformatf("compilation-unit item unit_only = %0d", unit_only));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
