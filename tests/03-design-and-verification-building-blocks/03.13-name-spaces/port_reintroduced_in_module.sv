/*
:section: 3.13 Name spaces
:summary: A port may be redeclared inside the module body as a variable or net of the same name.
*/
module doubler(a, y);
  input [7:0] a;
  output [7:0] y;
  wire [7:0] a;
  logic [7:0] y;
  always_comb y = a * 2;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [7:0] in_val, out_val;
  doubler u_doubler(.a(in_val), .y(out_val));
  initial begin
    in_val = 8'd21;
    #1;
    check(out_val == 8'd42, $sformatf("doubler output = %0d", out_val));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
