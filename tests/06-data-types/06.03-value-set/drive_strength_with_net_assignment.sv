/*
:section: 6.3.2.2 Drive strength
:summary: A net declaration may carry a drive strength together with an inline continuous
  assignment.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  wire (pull0, pull1) weak_one = 1'b1;
  assign weak_one = 1'b0;
  wire (strong0, strong1) strong_zero = 1'b0;
  assign (pull0, pull1) strong_zero = 1'b1;
  initial begin
    #1;
    check(weak_one === 1'b0, "a strong 0 did not override a pull 1 from the declaration");
    check(strong_zero === 1'b0, "a pull 1 overrode a strong 0 from the declaration");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
