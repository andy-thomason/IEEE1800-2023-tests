/*
:section: 20.6.2 Expression size system function
:summary: $bits gives the total bit count of an expression or type, counting a 4-state bit as
  one.
*/
module top;
  typedef struct packed { logic [6:0] tag; bit flag; logic [3:0][2:0] nibbles; } rec_t;
  rec_t r;
  logic [9:0] v;
  byte b;
  initial begin
    if ($bits(v) != 10) $display("FAIL: $bits(logic [9:0]) is %0d", $bits(v));
    else if ($bits(b) != 8) $display("FAIL: $bits(byte) is %0d", $bits(b));
    else if ($bits(rec_t) != 20) $display("FAIL: $bits(rec_t) is %0d", $bits(rec_t));
    else if ($bits(r) != 20) $display("FAIL: $bits(r) is %0d", $bits(r));
    else if ($bits({v, b}) != 18) $display("FAIL: $bits of concatenation is %0d", $bits({v, b}));
    else $display("PASS");
    $finish;
  end
endmodule
