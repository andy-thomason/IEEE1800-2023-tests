/*
:section: 7.12 Array manipulation methods
:summary: Range selects and properties may follow an array method call or its with clause to
  chain operations.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string tags [6] = '{"x", "y", "x", "z", "y", "x"};
  int nums [int] = '{1: 3, 2: 8, 3: 8, 4: 10};
  int r [$];
  initial begin
    check(tags.unique().size() == 3, "size() after unique()");
    r = nums.find(v) with (v > 5).unique;
    check(r.size() == 2, "unique after a with clause");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
