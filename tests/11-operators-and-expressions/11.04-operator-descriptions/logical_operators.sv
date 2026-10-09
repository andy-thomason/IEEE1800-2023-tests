/*
:section: 11.4.7 Logical operators
:summary: Logical connectives treat any nonzero known operand as true and yield x when the
  outcome is ambiguous.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] v4 = 4'b0100;
  logic x1 = 1'bx;
  initial begin
    check((v4 && 2) === 1'b1, "nonzero vectors are true");
    check((x1 && 1) === 1'bx && (x1 && 0) === 1'b0 && (x1 || 1) === 1'b1, "x in && and ||");
    check((0 -> x1) === 1'b1 && (1 -> 0) === 1'b0, "implication");
    check((1 <-> 1) === 1'b1 && (0 <-> 1) === 1'b0 && (x1 <-> 1) === 1'bx, "equivalence");
    check(!v4 === 1'b0 && !4'b0 === 1'b1 && !x1 === 1'bx, "logical negation");
    check((4'b0x00 || 0) === 1'bx, "a vector with only x and 0 bits is ambiguous");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
