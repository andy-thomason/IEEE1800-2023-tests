/*
:section: 15.4.6 Try_get()
:summary: try_get on a typeless mailbox returns a negative value on type mismatch and keeps the
  message.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  mailbox mb = new;
  string s;
  int i;
  initial begin
    mb.put(42);
    check(mb.try_get(s) < 0, "type mismatch did not return a negative value");
    check(mb.num() == 1, "a failed try_get removed the message");
    check(mb.try_get(i) > 0 && i == 42, "matching type");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
