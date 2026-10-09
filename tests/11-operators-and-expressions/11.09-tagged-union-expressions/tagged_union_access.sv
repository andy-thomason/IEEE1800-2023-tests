/*
:section: 11.9 Tagged union expressions and member access
:summary: Tagged union members are read and written with dot notation and must agree with the
  active tag.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef union tagged { void Empty; int Number; byte Letter; } val_t;
  val_t v;
  initial begin
    v = tagged Number 42;
    check(v.Number == 42, "read the current member");
    v.Number = 43;
    check(v.Number == 43, "write the current member");
    v = tagged Letter 8'h41;
    check(v.Letter == "A", "retag with a different member");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
