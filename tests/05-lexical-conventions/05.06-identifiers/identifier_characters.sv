/*
:section: 5.6 Identifiers, keywords, and system names
:summary: Simple identifiers may contain letters, digits, $ and _, beginning with a letter or
  underscore.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int data_$7 = 1;
  int _leading = 2;
  int A$b$c = 3;
  int x9_y8$ = 4;
  int __ = 5;
  initial begin
    check(data_$7 + _leading + A$b$c + x9_y8$ + __ == 15, "identifiers with letters, digits, $ and _");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
