/*
:section: 6.10 Implicit declarations
:summary: An identifier in a port expression implicitly becomes a net sized to the port
  expression.
*/
module inner(p, q);
  input [5:0] p;
  output [5:0] q;
  assign q = p + 6'd1;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [5:0] a = 6'd20;
  wire [5:0] b;
  inner u(.p(a), .q(b));
  initial begin
    #1;
    check($bits(u.p) == 6 && $bits(u.q) == 6, "port nets do not have the port width");
    check(b == 21, $sformatf("value through implicit port nets = %0d", b));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
