/*
:section: 6.14 Chandle data type
:summary: A chandle evaluates as false when null and true otherwise in a Boolean test.
:dpi: chandle_boolean_test.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function chandle counter_new(input int start);
  import "DPI-C" function void counter_free(input chandle h);
  chandle h;
  initial begin
    check(!h, "a null chandle tested as true");
    h = counter_new(1);
    check(h ? 1'b1 : 1'b0, "a non-null chandle tested as false");
    if (h) counter_free(h);
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
