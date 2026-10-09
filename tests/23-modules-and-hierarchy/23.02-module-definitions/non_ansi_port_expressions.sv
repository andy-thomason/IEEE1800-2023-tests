/*
:section: 23.2.2.1 Non-ANSI style port declarations
:summary: Non-ANSI port expressions may be bit-selects, part-selects or concatenations of
  internal signals.
*/
module split(.hi(bus[7:4]), .lo(bus[3:0]), .whole({top_bit, rest}));
  input [7:0] bus;
  output top_bit;
  output [2:0] rest;
  assign {top_bit, rest} = bus[7:4];
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  wire [3:0] h = 4'hA, l = 4'h5;
  wire [3:0] w;
  split u(.hi(h), .lo(l), .whole(w));
  initial begin
    #1;
    check(w == 4'hA, $sformatf("concatenated output port = %h", w));
    check(u.bus == 8'hA5, "part-select port expressions");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
