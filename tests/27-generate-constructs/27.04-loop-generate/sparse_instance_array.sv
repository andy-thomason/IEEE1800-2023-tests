/*
:section: 27.4 Loop generate constructs
:summary: A named loop generate block forms a possibly sparse array, declared even with zero
  iterations.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  for (genvar g = 1; g < 100; g = g * 3) begin : pow
    int v = g;
  end
  for (genvar g = 0; g < 0; g++) begin : never
    int v;
  end
  initial begin
    #1;
    check(pow[1].v == 1 && pow[3].v == 3 && pow[27].v == 27 && pow[81].v == 81, "sparse indices");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
