/*
:section: 30.4.5 Full connection and parallel connection paths
:summary: *> builds a full path connecting all source bits to all destination bits; => pairs
  bits one-to-one.
:flags-icarus: -gspecify
*/
module dut(input [1:0] a, input [1:0] b, output [2:0] y, output [1:0] z);
  assign y = {^a, a};
  assign z = b;
  specify
    (a *> y) = 4;
    (b => z) = 6;
  endspecify
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [1:0] a = 0, b = 0;
  wire [2:0] y;
  wire [1:0] z;
  dut u(.a(a), .b(b), .y(y), .z(z));
  initial begin
    #20 a = 2'b01; b = 2'b10;
    #3 check(y == 3'b000 && z == 2'b00, "nothing changed at 3");
    #2 check(y == 3'b101, $sformatf("full connection delay 4 gave %b", y));
    #2 check(z == 2'b10, "parallel connection delay 6");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
