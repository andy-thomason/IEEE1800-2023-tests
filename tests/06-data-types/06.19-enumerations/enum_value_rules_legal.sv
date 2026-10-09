/*
:section: 6.19 Enumerations
:summary: Unsized enum values are cast to the base type, and same-width sized literals are
  allowed.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef enum bit [3:0] {UA = 'h2, UB, UC = 'h9} unsized_t;
  typedef enum bit [3:0] {SA = 4'h2, SB, SC = 4'h9} sized_t;
  typedef enum logic signed [2:0] {NEG = -4, POS = 3} signed_t;
  initial begin
    check(UB == 3 && UC == 9, "unsized values in a 4-bit enum");
    check(SB == 3 && SC == 9, "4-bit sized values in a 4-bit enum");
    check(NEG == -4 && POS == 3, "signed range limits");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
