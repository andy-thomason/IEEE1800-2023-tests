/*
:section: 6.20.5 Specify parameters
:summary: Specparams may be declared in the module body or specify block and used in ordinary
  expressions.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  parameter int BASE = 3;
  specparam S1 = BASE * 2;
  specparam S2 = S1 + 1;
  specify
    specparam S3 = 40;
  endspecify
  int v;
  initial begin
    v = S2 * 10;
    check(v == 70, $sformatf("specparam in an expression gave %0d", v));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
