/*
:section: 15.3 Semaphores
:summary: Semaphores start with zero keys by default, put returns one key by default, and
  blocked getters resume when possible.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  semaphore none_left, two;
  int got_at = -1;
  initial begin
    none_left = new;
    two = new(2);
    check(none_left.try_get() == 0, "a semaphore created with no keys gave a key");
    check(two.try_get(2) > 0 && two.try_get() == 0, "try_get with a count");
    fork
      begin two.get(); got_at = $time; end
      #4 two.put();
    join
    check(got_at == 4, $sformatf("get() unblocked at %0t, expected when the key was returned", got_at));
    two.put(3);
    check(two.try_get(3) > 0, "put with a count");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
