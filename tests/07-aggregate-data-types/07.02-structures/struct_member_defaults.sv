/*
:section: 7.2.2 Assigning to structures
:summary: Struct members may have constant default values, which explicit variable initializers
  override.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  localparam int BASE = 10;
  typedef struct {
    int start = BASE + 2;
    int stop;
    byte marks [3] = '{3{8'd1}};
  } span_t;
  span_t defaulted;
  span_t explicit_init = '{100, 200, '{7, 8, 9}};
  initial begin
    check(defaulted.start == 12, "member default from a constant expression");
    check(defaulted.stop == 0, "member without a default does not have the int default");
    check(defaulted.marks[2] == 1, "array member default");
    check(explicit_init.start == 100 && explicit_init.marks[0] == 7, "explicit initialiser did not replace the member defaults");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
