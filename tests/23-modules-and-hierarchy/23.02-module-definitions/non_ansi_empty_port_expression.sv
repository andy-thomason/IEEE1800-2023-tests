/*
:section: 23.2.2.1 Non-ANSI style port declarations
:summary: A non-ANSI port may have an empty expression so that it connects to nothing inside the
  module.
*/
module stub(a, .nothing(), b);
  input a;
  output b;
  assign b = ~a;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic x = 0;
  wire y;
  stub u(.a(x), .nothing(), .b(y));
  initial begin
    #1;
    check(y === 1'b1, "port with no internal connection");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
