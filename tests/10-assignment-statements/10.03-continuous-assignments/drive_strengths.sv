/*
:section: 10.3.4 Continuous assignment strengths
:summary: A continuous assignment may specify strengths for driving 1 and 0 in either order,
  defaulting to strong.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  wire w_default, w_mixed, w_order;
  assign w_default = 1'b1;
  assign (weak0, weak1) w_default = 1'b0;
  assign (pull1, supply0) w_mixed = 1'b0;
  assign (strong0, strong1) w_mixed = 1'b1;
  assign (weak1, strong0) w_order = 1'b0;
  initial begin
    #1;
    check(w_default === 1'b1, "default strength is not strong");
    check(w_mixed === 1'b0, "supply0 did not beat strong1");
    check(w_order === 1'b0 && $sformatf("%v", w_order) == "St0", $sformatf("reversed strength order: %v", w_order));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
