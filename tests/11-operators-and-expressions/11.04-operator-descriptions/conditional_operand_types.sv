/*
:section: 11.4.11 Conditional operator
:summary: The conditional operator's result type depends on its two branch types, covering
  integral, real and class handle operands.
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
  class left_c extends base_c; endclass
  class right_c extends base_c; endclass
  left_c l = new;
  right_c rt = new;
  base_c b;
  bit sel = 1;
  real rr;
  int arr_a [2] = '{1, 2}, arr_b [2] = '{3, 4}, arr_r [2];
  initial begin
    rr = sel ? 1 : 2.5;
    check(rr == 1.0, "integral and real operands give real");
    b = sel ? l : rt;
    check(b == l, "classes with a common base");
    arr_r = sel ? arr_a : arr_b;
    check(arr_r[1] == 2, "equivalent unpacked array operands");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
