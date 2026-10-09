/*
:section: 40.3.2.2 $coverage_get_max
:summary: $coverage_get_max stays constant throughout simulation and bounds the value from
  $coverage_get.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] toggler;
  int max1, max2, got;
  initial begin
    max1 = $coverage_get_max(`SV_COV_TOGGLE, `SV_COV_HIER, $root);
    repeat (4) #1 toggler = $random;
    max2 = $coverage_get_max(`SV_COV_TOGGLE, `SV_COV_HIER, $root);
    got = $coverage_get(`SV_COV_TOGGLE, `SV_COV_HIER, $root);
    check(max1 == max2, $sformatf("maximum changed during simulation: %0d then %0d", max1, max2));
    check(max1 >= -2, "result is a status or a count");
    check(max1 <= 0 || (got >= 0 && got <= max1), $sformatf("covered count %0d is within 0..%0d", got, max1));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
