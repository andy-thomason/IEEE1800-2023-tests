/*
:section: 26.7 The std built-in package
:summary: User declarations may shadow std package names, while std:: still reaches the built-in
  version.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class semaphore;
    int tag = 77;
  endclass
  semaphore mine = new;
  std::semaphore real_one = new(1);
  initial begin
    check(mine.tag == 77, "a user class named semaphore hides the built-in one");
    check(real_one.try_get(1) == 1, "std:: still reaches the built-in");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
