/*
:section: 20.8.1 Integer math functions
:summary: $clog2 returns log base 2 rounded up, treating the argument as unsigned, and returns 0
  for 0.
*/
module top;
  logic [69:0] wide;
  initial begin
    wide = 70'd1 << 66;
    if ($clog2(0) != 0) $display("FAIL: $clog2(0) is %0d", $clog2(0));
    else if ($clog2(1) != 0) $display("FAIL: $clog2(1) is %0d", $clog2(1));
    else if ($clog2(2) != 1) $display("FAIL: $clog2(2) is %0d", $clog2(2));
    else if ($clog2(5) != 3) $display("FAIL: $clog2(5) is %0d", $clog2(5));
    else if ($clog2(256) != 8) $display("FAIL: $clog2(256) is %0d", $clog2(256));
    else if ($clog2(257) != 9) $display("FAIL: $clog2(257) is %0d", $clog2(257));
    else if ($clog2(-1) != 32) $display("FAIL: $clog2(-1) treated as signed, gave %0d", $clog2(-1));
    else if ($clog2(wide) != 66) $display("FAIL: $clog2(2**66) is %0d", $clog2(wide));
    else if ($clog2(wide + 70'd1) != 67) $display("FAIL: $clog2(2**66+1) is %0d", $clog2(wide + 70'd1));
    else $display("PASS");
    $finish;
  end
endmodule
