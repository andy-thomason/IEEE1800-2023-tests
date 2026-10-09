/*
:section: 23.10.1 defparam statement
:summary: A defparam inside a generate block can only change parameters within that generate
  hierarchy.
*/
module leaf #(parameter int P = 1); endmodule
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  leaf outside();
  for (genvar g = 0; g < 2; g++) begin : gen
    leaf inner();
    defparam inner.P = 10 + g;
  end
  initial begin
    check(gen[0].inner.P == 10 && gen[1].inner.P == 11, "defparam inside generate blocks");
    check(outside.P == 1, "defparam changed a parameter outside its generate block");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
