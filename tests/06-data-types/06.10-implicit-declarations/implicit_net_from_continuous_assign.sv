/*
:section: 6.10 Implicit declarations
:summary: An undeclared identifier on a continuous assignment left side becomes an implicit
  scalar net.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [2:0] src = 3'b110;
  assign implicit_lhs = src[2];
  initial begin
    #1;
    check($bits(implicit_lhs) == 1 && implicit_lhs === 1'b1, "implicit net from an assign");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
