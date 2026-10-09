/*
:section: 11.4.5 Equality operators
:summary: Case equality compares x and z bits exactly, while logical equality yields x when
  unknown bits are involved.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] a = 4'b10x1, b = 4'b10x1, c = 4'b11x1;
  real r = 3.0;
  initial begin
    check((a == b) === 1'bx, "== with x in both is ambiguous");
    check((a == c) === 1'b0, "== is 0 when a known bit differs");
    check((a === b) === 1'b1 && (a !== c) === 1'b1, "=== compares x bits");
    check((4'bz === 4'bx) === 1'b0, "z and x are different for ===");
    check((4'b0011 == 2'b11) === 1'b1, "zero-extension of the shorter operand");
    check((r == 3) === 1'b1, "real compared with an integer");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
