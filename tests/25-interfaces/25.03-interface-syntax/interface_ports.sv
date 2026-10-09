/*
:section: 25.4 Ports in interfaces
:summary: An interface may have its own ports so external signals are shared with its contents.
*/
interface clocked_if(input logic clk, input logic rst);
  int edges;
  always @(posedge clk) edges <= rst ? 0 : edges + 1;
endinterface
module watcher(clocked_if b, output int seen);
  assign seen = b.edges;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic clk = 0, rst = 1;
  int seen;
  clocked_if bus(.clk(clk), .rst(rst));
  watcher w(.b(bus), .seen(seen));
  initial begin
    #1;
    #1 clk = 1; #1 clk = 0;
    rst = 0;
    repeat (3) begin #1 clk = 1; #1 clk = 0; end
    check(seen == 3, $sformatf("edges counted through interface ports = %0d", seen));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
