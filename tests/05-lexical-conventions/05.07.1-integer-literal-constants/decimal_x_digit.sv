/*
:section: 5.7.1 Integer literal constants
:summary: A decimal literal may be a single x or z digit, setting every bit to that value.
*/
module top;
  logic [5:0] a, b;
  initial begin
    a = 6'dx;
    b = 6'dz;
    if (a !== 6'bxxxxxx) $display("FAIL: 6'dx gave %b", a);
    else if (b !== 6'bzzzzzz) $display("FAIL: 6'dz gave %b", b);
    else $display("PASS");
    $finish;
  end
endmodule
