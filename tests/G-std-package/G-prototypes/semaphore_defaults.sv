/*
:section: G.3 Semaphore
:summary: A new std::semaphore starts with zero keys, and put, get and try_get default to one
  key.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  std::semaphore s = new;
  initial begin
    check(s.try_get() == 0, "new() starts with no keys");
    s.put();
    check(s.try_get() == 1, "put() and try_get() default to one key");
    check(s.try_get() == 0, "only one key was put");
    s.put(2);
    s.get();
    check(s.try_get(1) == 1 && s.try_get(1) == 0, "get() took one of two keys");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
