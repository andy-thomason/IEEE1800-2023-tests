/*
:section: 27.5 Conditional generate constructs
:summary: A module may instantiate itself recursively through conditional generate with
  parameters ending the recursion.
*/
module popcount #(parameter int W = 8) (input logic [W-1:0] v, output int n);
  if (W == 1) begin : leaf
    assign n = v[0];
  end else begin : split
    int lo, hi;
    popcount #(W / 2) l(.v(v[W/2-1:0]), .n(lo));
    popcount #(W - W / 2) h(.v(v[W-1:W/2]), .n(hi));
    assign n = lo + hi;
  end
endmodule
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [10:0] v = 11'b101_1100_1110;
  int n;
  popcount #(11) u(.v(v), .n(n));
  initial begin
    #1;
    check(n == 7, $sformatf("recursive popcount = %0d", n));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
