/*
:section: 6.24.1 Cast operator
:summary: A constant positive size cast pads or truncates its operand to the given width.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  parameter int P = 6;
  parameter int Q = 3;
  logic [11:0] x = 12'hABC;
  logic [7:0] r8;
  initial begin
    check(4'(x) === 4'hC, "4'(x) did not truncate");
    check($bits(P'(x)) == 6 && P'(x) === 6'h3C, "parameter size cast");
    check($bits((Q + 1)'(x)) == 4, "expression size cast");
    check($bits(16'(x)) == 16 && 16'(x) === 16'h0ABC, "widening cast did not zero-pad");
    r8 = 6'(4'sb1000);
    check(r8 === 8'hF8, $sformatf("6'(4'sb1000) widened to 8 bits = %h; the result should stay signed", r8));
    check(6'(4'b1000) == 6'b001000, "unsigned value zero-padded");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
