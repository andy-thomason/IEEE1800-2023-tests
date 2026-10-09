/*
:section: 10.4.1 Blocking procedural assignments
:summary: Blocking assignments complete before subsequent statements in a sequential block run.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int a = 1, b = 2, c;
  int idx = 0;
  int arr [3];
  initial begin
    a = b;
    b = a;
    check(a == 2 && b == 2, "sequential blocking assignments");
    fork
      #3 c = 5;
      check(c == 0, "a delayed assignment in a fork blocked the next branch");
    join
    arr[idx] = #1 7;
    check(arr[0] == 7, "assignment with an intra-assignment delay");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
