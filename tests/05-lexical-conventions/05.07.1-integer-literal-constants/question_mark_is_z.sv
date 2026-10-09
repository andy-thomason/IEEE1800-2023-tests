/*
:section: 5.7.1 Integer literal constants
:summary: In a number, ? stands for z and covers 4, 3 or 1 bits by base.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  initial begin
    check(8'h?3 === 8'bzzzz_0011, "8'h?3");
    check(6'o?1 === 6'bzzz_001, "6'o?1");
    check(4'b1?0? === 4'b1z0z, "4'b1?0?");
    check(5'd? === 5'bzzzzz, "5'd?");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
