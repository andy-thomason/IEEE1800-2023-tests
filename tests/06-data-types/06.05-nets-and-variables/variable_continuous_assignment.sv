/*
:section: 6.5 Nets and variables
:summary: Different elements of one struct or array may be driven procedurally and continuously.
*/
module source(output logic [1:0] o);
  assign o = 2'b10;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  struct { logic [3:0] a; logic [3:0] b; byte c; } rec;
  logic [3:0] bits;
  logic whole;
  logic [1:0] from_port;
  logic in1 = 1'b1, in2 = 1'b0;
  assign whole = in1 & ~in2;
  assign rec.a = 4'd3;
  assign rec.c = 8'd9;
  assign bits[0] = 1'b1;
  not g(bits[1], 1'b1);
  source u(.o(from_port));
  initial begin
    rec.b = 4'd5;
    bits[3:2] = 2'b11;
    #1;
    check(whole === 1'b1, "variable driven by one continuous assignment");
    check(rec.a == 3 && rec.b == 5 && rec.c == 9, "struct members driven continuously and procedurally");
    check(bits === 4'b1101, $sformatf("bits = %b, expected 1101 from four independent writers", bits));
    check(from_port === 2'b10, "variable driven by a port");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
