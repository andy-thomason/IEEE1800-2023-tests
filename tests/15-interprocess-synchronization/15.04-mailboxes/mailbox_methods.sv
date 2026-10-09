/*
:section: 15.4 Mailboxes
:summary: Mailbox methods num, put, try_put, get, try_get, peek and try_peek follow FIFO order
  and report status.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  mailbox #(int) mb;
  int v;
  initial begin
    mb = new(2);
    check(mb.num() == 0 && mb.try_get(v) == 0 && mb.try_peek(v) == 0, "empty mailbox");
    mb.put(10);
    check(mb.try_put(20) > 0 && mb.try_put(30) == 0, "try_put on a bounded mailbox");
    check(mb.num() == 2, "num");
    mb.peek(v);
    check(v == 10 && mb.num() == 2, "peek does not remove");
    check(mb.try_get(v) > 0 && v == 10 && mb.num() == 1, "try_get removes in FIFO order");
    mb.get(v);
    check(v == 20, "get in FIFO order");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
