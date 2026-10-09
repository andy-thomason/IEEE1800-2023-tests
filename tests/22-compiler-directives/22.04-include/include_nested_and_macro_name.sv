/*
:section: 22.4 `include
:summary: Included files may themselves contain `include directives, and the file name can come
  from a macro.
:includes: include_nested_and_macro_name_outer.svh include_nested_and_macro_name_inner.svh
*/
`define INC_NAME(f) `"f`"
`include `INC_NAME(include_nested_and_macro_name_outer.svh)

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask

  initial begin
    check(OUTER_VALUE == 1 && INNER_VALUE == 2, "nested includes");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
