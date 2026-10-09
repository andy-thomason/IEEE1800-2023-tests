/*
:section: 11.4.3 Arithmetic operators
:summary: The remainder from % carries the sign of the dividend and is zero for exact division.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int a, b, r;
  initial begin
    a = 29; b = 7;   r = a % b; check(r == 1, $sformatf("29 %% 7 = %0d", r));
    a = 28;          r = a % b; check(r == 0, $sformatf("28 %% 7 = %0d (exact division)", r));
    a = 6;           r = a % b; check(r == 6, $sformatf("6 %% 7 = %0d", r));
    a = -29;         r = a % b; check(r == -1, $sformatf("-29 %% 7 = %0d, expected -1", r));
    a = 29; b = -7;  r = a % b; check(r == 1, $sformatf("29 %% -7 = %0d, expected 1", r));
    a = -29;         r = a % b; check(r == -1, $sformatf("-29 %% -7 = %0d, expected -1", r));
    a = -28;         r = a % b; check(r == 0, $sformatf("-28 %% -7 = %0d", r));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
