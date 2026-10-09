/*
:section: 23.11 Binding auxiliary code to scopes or instances
:summary: A bind directive can insert an instance into all instances of a module or one specific
  instance.
*/
module watcher(input int v, output int seen);
  assign seen = v * 10;
endmodule
module dut;
  int value = 3;
  int seen;
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
  bind dut watcher w_all(.v(value), .seen());
  initial begin
    #1;
    check(a.w_all.seen == 30 && b.w_all.seen == 30, "bind to every instance of a module");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
