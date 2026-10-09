/*
:section: 6.19 Enumerations
:summary: A 4-state enum may contain names whose values include x or z bits.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef enum logic [1:0] {IDLE = 2'b00, UNKNOWN = 2'bxx, RUN = 2'b01, HALT = 2'bz1} mode_t;
  mode_t m;
  initial begin
    m = UNKNOWN;
    check(m === 2'bxx, "x-valued name");
    m = HALT;
    check(m === 2'bz1, "z-valued name");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
