/*
:section: 16.3 Immediate assertions
:summary: During simulation, an immediate assume acts just like assert, running its pass or fail
  action.
:flags-verilator: --coverage-user
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int assumed = 0, rejected = 0;
  logic [1:0] v;
  initial begin
    v = 2'b00; assume (v == 0) assumed++; else rejected++;
    v = 2'b11; assume (v == 0) assumed++; else rejected++;
    check(v == 2'b11, "the assumption changed the value being checked");
    check(assumed == 1 && rejected == 1, $sformatf("assume passes %0d, failures %0d", assumed, rejected));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
