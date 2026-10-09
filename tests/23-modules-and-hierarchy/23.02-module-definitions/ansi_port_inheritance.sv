/*
:section: 23.2.2.3 Rules for determining port kind, data type, and direction
:summary: Later ANSI ports with omitted direction and type inherit them from the previous port
  in the list.
*/
module shapes(input [3:0] a, b, output int c, d, input e [2]);
  assign c = $bits(a) + $bits(b);
  assign d = $size(e);
endmodule
module bidir(x);
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] p = 1, q = 2;
  int r, s;
  logic t [2];
  shapes u(.a(p), .b(q), .c(r), .d(s), .e(t));
  initial begin
    #1;
    check(r == 8, "b inherited the [3:0] range from a");
    check(s == 2, "unpacked port dimension");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
