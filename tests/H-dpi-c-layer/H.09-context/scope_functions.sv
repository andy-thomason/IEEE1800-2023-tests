/*
:section: H.9.3 Working with DPI context tasks and functions in C code
:summary: svGetScope returns the import declaration scope unless svSetScope has changed it for
  export calls.
:dpi: scope_functions.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" context function int where_am_i(output string name);
  import "DPI-C" context function int call_in(input string scope_name);
  import "DPI-C" context function int unknown_scope_is_null();
  cell_m c1(), c2();
  string name;
  initial begin
    void'(where_am_i(name));
    check(name == "top", $sformatf("declaration scope name '%s'", name));
    check(call_in("top.c1") == 101 && call_in("top.c2") == 102, "svSetScope selects which instance's export runs");
    check(unknown_scope_is_null() == 1, "svGetScopeFromName of an unknown name is NULL");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule

module cell_m;
  export "DPI-C" function report_id;
  function int report_id();
    string n = $sformatf("%m");
    return n == "top.c1.report_id" ? 101 : 102;
  endfunction
endmodule
