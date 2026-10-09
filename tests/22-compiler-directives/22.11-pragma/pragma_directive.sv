/*
:section: 22.11 `pragma
:summary: `pragma accepts tool-specific names, and `pragma reset or resetall returns pragma
  settings to defaults.
*/
`pragma some_tool_option value = 1
`pragma reset some_tool_option
`pragma resetall

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask

  initial begin
    check(1, "unknown pragmas are accepted");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
