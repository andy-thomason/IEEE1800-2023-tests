/*
:section: 23.3.3.8 Connecting signed values via ports
:summary: Signedness does not pass through ports, so a port must be declared signed to treat
  values as signed.
*/
module unsigned_in(input [3:0] v, output bit negative);
  assign negative = v < 0;
endmodule
module signed_in(input signed [3:0] v, output bit negative);
  assign negative = v < 0;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic signed [3:0] neg = -2;
  bit n1, n2;
  unsigned_in u1(.v(neg), .negative(n1));
  signed_in u2(.v(neg), .negative(n2));
  initial begin
    #1;
    check(!n1, "the sign crossed into an unsigned port");
    check(n2, "a signed port did not treat the value as signed");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
