/*
:section: 7.8.3 Class index
:summary: A class-indexed associative array accepts base, derived and null handles as keys.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class base_c; endclass
  class derived_c extends base_c; endclass
  int by_obj [base_c];
  base_c b1 = new, b2 = new;
  derived_c d = new;
  base_c none;
  initial begin
    by_obj[b1] = 1;
    by_obj[b2] = 2;
    by_obj[d] = 3;
    by_obj[none] = 4;
    check(by_obj.num() == 4, "class, derived and null indices");
    check(by_obj[b2] == 2 && by_obj[d] == 3 && by_obj[null] == 4, "lookup by object");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
