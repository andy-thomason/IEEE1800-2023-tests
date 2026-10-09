/*
:section: 23.3.2 Module instantiation syntax
:summary: Ports may connect by position, by explicit name, by implicit .name, or by .* wildcard.
*/
module mac(input [3:0] a, input [3:0] b, input [7:0] acc, output [7:0] y);
  assign y = a * b + acc;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] a = 3, b = 4;
  logic [7:0] acc = 10;
  wire [7:0] y1, y2, y3, y;
  mac u1(a, b, acc, y1);
  mac u2(.a(a), .b(b), .acc(acc), .y(y2));
  mac u3(.a, .b, .acc(8'd0), .y(y3));
  mac u4(.*, .acc(8'd1));
  initial begin
    #1;
    check(y1 == 22 && y2 == 22, "ordered and named");
    check(y3 == 12, "implicit .name mixed with an explicit connection");
    check(y == 13, ".* mixed with an explicit connection");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
