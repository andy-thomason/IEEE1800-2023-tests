/*
:section: 15.5.4 Event sequencing: wait_order()
:summary: wait_order succeeds when events fire in the listed sequence and fails if one fires out
  of order.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  event a, b, c;
  bit ok1 = 0, ok2 = 1;
  initial begin
    fork
      wait_order (a, b, c) ok1 = 1; else ok1 = 0;
      begin #1 -> a; #1 -> b; #1 -> c; end
    join
    check(ok1, "in-order triggers did not succeed");
    fork
      wait_order (a, b, c) ok2 = 1; else ok2 = 0;
      begin #1 -> a; #1 -> c; #1 -> b; end
    join_any
    #3;
    check(!ok2, "out-of-order triggers did not fail");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
