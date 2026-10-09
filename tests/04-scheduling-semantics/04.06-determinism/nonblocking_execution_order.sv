/*
:section: 4.6 Determinism
:summary: Nonblocking assignments take effect in the same order the statements executed, so the
  last write wins.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int count = 0;
  logic [7:0] v = 8'hAA;
  initial begin
    #1;
    count <= 5;
    count <= 9;
    count <= 2;
    v <= 8'h00;
    v[0] <= 1'b1;
    v[7:4] <= 4'hC;
    #1;
    check(count == 2, $sformatf("count = %0d, expected the last NBA (2)", count));
    check(v == 8'hC1, $sformatf("v = %h, expected c1 from the NBAs applied in order", v));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
