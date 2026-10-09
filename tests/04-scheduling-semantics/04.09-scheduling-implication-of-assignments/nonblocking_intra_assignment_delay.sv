/*
:section: 4.9.4 Nonblocking assignment
:summary: A delayed nonblocking assignment captures its right side and target index immediately
  without blocking the process.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int d = 4, q = 0;
  int arr [0:3];
  int idx = 1;
  initial begin
    foreach (arr[i]) arr[i] = 0;
    #0;
    arr[idx] <= #3 7;
    q <= #6 d;
    check($time == 0, "a nonblocking assignment with a delay blocked the process");
    idx = 2;
    d = 40;
    #4;
    check(arr[1] == 7, $sformatf("arr[1] = %0d at time 4, expected 7", arr[1]));
    check(arr[2] == 0, $sformatf("arr[2] = %0d; the target must use the index at scheduling time", arr[2]));
    check(q == 0, "q was updated before its delay");
    #3;
    check(q == 4, $sformatf("q = %0d; the right-hand side should be the value of d at time 0", q));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
