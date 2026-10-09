/*
:section: G.4 Mailbox
:summary: A mailbox with no type parameter is dynamically typed and accepts messages of
  differing types.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  std::mailbox any_box = new();
  initial begin
    int i;
    string s;
    any_box.put(7);
    any_box.put("text");
    check(any_box.try_get(i) == 1 && i == 7, "int message");
    check(any_box.try_get(s) == 1 && s == "text", "string message in the same mailbox");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
