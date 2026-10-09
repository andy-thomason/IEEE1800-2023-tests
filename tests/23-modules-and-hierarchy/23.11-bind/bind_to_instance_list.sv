/*
:section: 23.11 Binding auxiliary code to scopes or instances
:summary: A bind can target a listed subset of instances of a module rather than every instance.
*/
module watcher(input int v, output int seen);
  assign seen = v * 10;
endmodule
module dut;
  int value = 3;
  int seen = -1;
endmodule
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  dut a();
  dut b();
  bind dut: b watcher w_b(.v(value), .seen(seen));
  initial begin
    #1;
    check(b.seen == 30, "bound instance drives b.seen");
    check(a.seen == -1, "instance a was not in the list");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
