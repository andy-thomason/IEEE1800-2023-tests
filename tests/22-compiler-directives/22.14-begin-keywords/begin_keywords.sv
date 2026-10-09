/*
:section: 22.14 `begin_keywords, `end_keywords
:summary: `begin_keywords with an older version lets later SystemVerilog keywords like logic and
  bit be used as identifiers.
*/
`begin_keywords "1364-2005"
module old_style;
  reg logic;
  reg bit;
  initial begin logic = 1; bit = 0; end
endmodule
`end_keywords
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  old_style u();
  initial begin
    #1;
    check(u.logic == 1 && u.bit == 0, "SystemVerilog keywords used as identifiers under 1364-2005");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
