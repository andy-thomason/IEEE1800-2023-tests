/*
:section: 5.7.1 Integer literal constants
:summary: Unsized literals are at least 32 bits wide, growing when the value needs more bits.
*/
module top;
  initial begin
    if ($bits(1) < 32) $display("FAIL: $bits(1) is %0d", $bits(1));
    else if ($bits('o17) < 32) $display("FAIL: $bits('o17) is %0d", $bits('o17));
    else if ($bits('h1_2345_6789) < 33) $display("FAIL: $bits('h1_2345_6789) is %0d", $bits('h1_2345_6789));
    else if (64'('h1_2345_6789) != 64'h0000_0001_2345_6789) $display("FAIL: wide unsized value was truncated");
    else $display("PASS");
    $finish;
  end
endmodule
