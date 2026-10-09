/*
:section: 5.7.1 Integer literal constants
:summary: The size, base and digits of an integer literal may each come from macro expansion.
*/
`define WIDTH 6
`define HEX 'h
`define DIGITS 2A
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  initial begin
    check(`WIDTH`HEX`DIGITS === 6'h2A, "size, base and digits from macros");
    check($bits(`WIDTH`HEX`DIGITS) == 6, "width from a macro size");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
