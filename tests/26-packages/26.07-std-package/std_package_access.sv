/*
:section: 26.7 The std built-in package
:summary: std package items like semaphore and mailbox are usable directly or through the std::
  prefix.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  std::semaphore s1 = new(1);
  semaphore s2 = new(2);
  std::mailbox #(int) mb = new;
  initial begin
    int v;
    check(s1.try_get(1) == 1 && s1.try_get(1) == 0, "std::semaphore");
    check(s2.try_get(2) == 1, "semaphore without the std prefix");
    mb.put(9);
    mb.get(v);
    check(v == 9, "std::mailbox");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
