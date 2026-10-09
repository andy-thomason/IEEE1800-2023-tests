/*
:section: 34.2 Overview
:summary: Protect pragma expressions may be split over several directives without changing their
  meaning.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  `pragma protect author = "Example Author"
  `pragma protect author_info = "unit test"
  `pragma protect data_keyowner = "nobody", data_keyname = "none"
  `pragma protect viewport = (object = "top.value", access = "RW")
  int value = 7;
  `pragma protect reset
  initial begin
    #1;
    check(value == 7, "split protect directives leave the source unchanged");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
