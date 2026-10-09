/*
:section: 11.4.10 Shift operators
:summary: Logical shifts fill vacated bits with zeros, while >>> on a signed value fills from
  the sign bit.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [7:0] u = 8'b1001_0110;
  logic signed [7:0] s = 8'sb1001_0110;
  logic signed [3:0] neg_amount = -1;
  logic [7:0] r;
  initial begin
    r = u << 2;    check(r == 8'b0101_1000, "<<");
    r = u >> 3;    check(r == 8'b0001_0010, ">>");
    r = u >>> 3;   check(r == 8'b0001_0010, ">>> on unsigned fills with zeros");
    r = s >>> 3;   check(r == 8'b1111_0010, ">>> on signed fills with the sign bit");
    r = s >> 3;    check(r == 8'b0001_0010, ">> on signed fills with zeros");
    r = s <<< 1;   check(r == 8'b0010_1100, "<<<");
    r = u << 4'bx01; check(r === 8'hxx, "x shift amount gives x");
    r = u >> neg_amount; check(r == 0, "a signed shift amount is treated as unsigned (15)");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
