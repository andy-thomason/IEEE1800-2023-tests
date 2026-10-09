/*
:section: 6.10 Implicit declarations
:summary: Undeclared identifiers in instance port connections or primitive terminals become
  implicit scalar nets.
*/
module source(output logic [3:0] o);
  assign o = 4'b0101;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  source u(.o(auto_net));
  and g(gate_out, 1'b1, 1'b1);
  initial begin
    #1;
    check($bits(auto_net) == 1, $sformatf("implicit net is %0d bits, expected a scalar", $bits(auto_net)));
    check(auto_net === 1'b1, "implicit net did not get the low bit of the port");
    check(gate_out === 1'b1, "implicit net on a primitive terminal");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
