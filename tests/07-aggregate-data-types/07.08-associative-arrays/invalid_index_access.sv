/*
:section: 7.8.6 Accessing invalid indices
:summary: Reading a missing associative entry returns the default; writes with x/z keys are
  ignored.
:description: Warnings are required but their text is tool-specific, so only values are checked.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int two [int];
  logic [7:0] four [integer];
  string names [int];
  integer bad_key = 'x;
  initial begin
    check(two[5] == 0, "missing 2-state entry");
    check(four[5] === 8'hxx, "missing 4-state entry");
    check(names[1] == "", "missing string entry");
    four[bad_key] = 8'h11;
    check(four.num() == 0, "a write with an x index was not ignored");
    four[1] = 8'h22;
    check(four[bad_key] === 8'hxx, "a read with an x index did not return the default");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
