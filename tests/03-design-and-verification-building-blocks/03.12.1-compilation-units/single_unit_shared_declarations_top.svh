module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  six_bits_t v;
  initial begin
    check($bits(v) == 6, $sformatf("$bits(six_bits_t) = %0d", $bits(v)));
    check(SHARED_LIMIT == 42, $sformatf("SHARED_LIMIT = %0d", SHARED_LIMIT));
    check(twice(21) == 42, $sformatf("twice(21) = %0d", twice(21)));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
