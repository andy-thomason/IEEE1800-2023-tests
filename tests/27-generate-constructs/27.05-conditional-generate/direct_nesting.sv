/*
:section: 27.5 Conditional generate constructs
:summary: An unbracketed conditional generate nested in an else branch is directly nested and
  shares the outer scope.
*/
module chain #(parameter int N = 0) (output int r);
  if (N == 0) begin : choice
    assign r = 10;
  end else if (N == 1) begin : choice
    assign r = 11;
  end else
    case (N)
      2: begin : choice assign r = 12; end
      default: begin : choice assign r = 19; end
    endcase
endmodule
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int r0, r1, r2, r9;
  chain #(0) c0(.r(r0));
  chain #(1) c1(.r(r1));
  chain #(2) c2(.r(r2));
  chain #(9) c9(.r(r9));
  initial begin
    #1;
    check(r0 == 10 && r1 == 11 && r2 == 12 && r9 == 19, "if-else-if and nested case selected the right block");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
