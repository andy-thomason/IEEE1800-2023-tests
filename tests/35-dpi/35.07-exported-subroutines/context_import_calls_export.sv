/*
:section: 35.5.3 Context tasks and functions
:summary: An imported function that calls an exported SystemVerilog function must be declared
  context.
:dpi: context_import_calls_export.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  export "DPI-C" function sv_scale;
  import "DPI-C" context function int c_apply(input int x);
  int factor = 6;
  function int sv_scale(input int v);
    return v * factor;
  endfunction
  initial begin
    check(c_apply(7) == 43, "C called the exported SystemVerilog function");
    factor = 2;
    check(c_apply(7) == 15, "the export sees current module state");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
