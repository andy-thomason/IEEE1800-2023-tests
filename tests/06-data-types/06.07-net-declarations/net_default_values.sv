/*
:section: 6.7.1 Net declarations with built-in net types
:summary: Undriven nets start at z, driven nets follow their drivers, and trireg nets start at
  x.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  wire [3:0] undriven;
  wire [3:0] driven = 4'd6;
  trireg [1:0] store;
  initial begin
    #1;
    check(undriven === 4'bzzzz, $sformatf("undriven wire = %b", undriven));
    check(driven === 4'd6, "driven wire");
    check(store === 2'bxx, $sformatf("undriven trireg = %b, expected x", store));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
