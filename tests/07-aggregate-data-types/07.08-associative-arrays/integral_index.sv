/*
:section: 7.8.4 Integral index
:summary: Integral associative keys are converted to the declared index type and ordered by its
  signedness.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef bit signed [3:0] snib_t;
  typedef bit [3:0] unib_t;
  int by_signed [snib_t];
  int by_unsigned [unib_t];
  snib_t sk;
  unib_t uk;
  initial begin
    by_signed[3] = 1; by_signed[-2] = 2; by_signed[7] = 3;
    void'(by_signed.first(sk));
    check(sk == -2, $sformatf("signed ordering starts at %0d", sk));
    by_unsigned[3] = 1; by_unsigned[4'hE] = 2;
    void'(by_unsigned.first(uk));
    check(uk == 3, "unsigned ordering");
    by_unsigned[17] = 9;
    check(by_unsigned.exists(1) && by_unsigned[1] == 9, "index was not cast to 4 bits");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
