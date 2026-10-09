/*
:section: 6.9.1 Specifying vectors
:summary: reg, logic and bit vectors are unsigned unless declared signed or bound to a signed
  port.
*/
module signed_port(input logic signed [3:0] p, output logic neg);
  assign neg = p < 0;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] u = 4'b1111;
  logic signed [3:0] s = 4'b1111;
  logic neg;
  signed_port m(.p(u), .neg(neg));
  initial begin
    #1;
    check(u > 0, "unsigned vector compared as negative");
    check(s < 0, "signed vector compared as positive");
    check(neg === 1'b1, "the value seen through a signed port is not negative");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
