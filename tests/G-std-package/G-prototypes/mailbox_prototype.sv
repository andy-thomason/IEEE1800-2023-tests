/*
:section: G.4 Mailbox
:summary: The std mailbox class offers put, get, try_put, try_get, peek and num, unbounded by
  default.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  std::mailbox #(string) typed = new;
  initial begin
    string s;
    int i;
    for (int k = 0; k < 50; k++) check(typed.try_put($sformatf("m%0d", k)) == 1, "default bound 0 is unbounded");
    check(typed.num() == 50, "num");
    check(typed.try_peek(s) == 1 && s == "m0" && typed.num() == 50, "try_peek leaves the message");
    typed.get(s);
    check(s == "m0" && typed.num() == 49, "get removes in order");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
