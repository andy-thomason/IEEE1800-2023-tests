/*
:section: 6.10 Implicit declarations
:summary: Implicitly declared nets take the type chosen by `default_nettype, such as wand.
*/
`default_nettype wand
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  assign joined = 1'b1;
  assign joined = 1'b0;
  initial begin
    #1;
    check(joined === 1'b0, $sformatf("implicit wand net = %b, expected 0 (wired AND)", joined));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
`default_nettype wire
