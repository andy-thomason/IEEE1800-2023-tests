/*
:section: 15.4.3 Put()
:summary: A full bounded mailbox blocks put, an empty mailbox blocks get, and peek leaves the
  message in place.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  mailbox #(string) mb = new(1);
  int put_done = -1, peek1 = -1, peek2 = -1;
  string a, b;
  initial begin
    mb.put("one");
    fork
      begin mb.put("two"); put_done = $time; end
      #3 void'(mb.try_get(a));
    join
    check(put_done == 3, $sformatf("put on a full bounded mailbox returned at %0t", put_done));
    void'(mb.try_get(a));
    fork
      begin mb.peek(a); peek1 = $time; end
      begin mb.peek(b); peek2 = $time; end
      #2 mb.put("three");
    join
    check(peek1 == 2 && peek2 == 2 && a == "three" && b == "three", "one message unblocked both peeks");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
