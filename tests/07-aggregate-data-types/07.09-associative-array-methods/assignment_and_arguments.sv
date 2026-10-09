/*
:section: 7.9.9 Associative array assignment
:summary: Associative array assignment replaces the target contents, and by-value arguments
  receive a copy.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int src [string], dst [string];
  function automatic int add_and_count(int m [string]);
    m["new"] = 0;
    return m.num();
  endfunction
  initial begin
    src["a"] = 1; src["b"] = 2;
    dst["old"] = 9;
    dst = src;
    check(dst.num() == 2 && !dst.exists("old") && dst["b"] == 2, "target was not cleared before the copy");
    check(add_and_count(src) == 3 && src.num() == 2, "the argument is not a local copy");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
