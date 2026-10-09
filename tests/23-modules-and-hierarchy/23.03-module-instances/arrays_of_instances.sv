/*
:section: 23.3.3.5 Unpacked array ports and arrays of instances
:summary: An array of instances splits a wide or array connection among instances, or shares a
  matching scalar connection.
*/
module slice(input [1:0] a, input en, input int k, output [1:0] y);
  assign y = en ? a + k[1:0] : 2'b00;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [7:0] packed_in = 8'b11_10_01_00;
  logic en = 1;
  int ks [4] = '{0, 1, 0, 1};
  wire [7:0] packed_out;
  slice u[3:0] (.a(packed_in), .en(en), .k(ks), .y(packed_out));
  initial begin
    #1;
    check(u[0].a == 2'b00 && u[3].a == 2'b11, "packed connection split right to left");
    check(u[3].k == 0 && u[0].k == 1, "unpacked array elements matched left to right");
    check(packed_out == 8'b11_11_01_01, $sformatf("outputs %b", packed_out));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
