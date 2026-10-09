/*
:section: 13.5.2 Pass by reference
:summary: Arguments passed by ref share storage with the caller, so changes are visible on both
  sides.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int data [4] = '{1, 2, 3, 4};
  int shared_v = 0;
  task automatic watch(ref int r, output int seen);
    #2 seen = r;
  endtask
  function automatic void bump_all(ref int arr [4]);
    foreach (arr[i]) arr[i]++;
  endfunction
  function automatic int total(const ref int arr [4]);
    return arr.sum();
  endfunction
  function automatic void by_value(int arr [4]);
    arr[0] = 100;
  endfunction
  int seen;
  initial begin
    fork
      watch(shared_v, seen);
      #1 shared_v = 42;
    join
    check(seen == 42, "a change by the caller is visible through ref");
    bump_all(data);
    check(data[3] == 5, "a change through ref is visible to the caller");
    check(total(data) == 14, "const ref read");
    by_value(data);
    check(data[0] == 2, "pass by value changed the caller's array");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
