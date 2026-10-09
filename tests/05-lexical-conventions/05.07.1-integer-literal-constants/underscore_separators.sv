/*
:section: 5.7.1 Integer literal constants
:summary: Underscores inside numeric literals are permitted and have no effect on the value.
*/
module top;
  initial begin
    if (16'b1100__0011_1010_0101 != 16'hC3A5) $display("FAIL: binary with underscores");
    else if (1_000_000 != 1000000) $display("FAIL: decimal with underscores");
    else if (8'o3_7_7 != 8'd255) $display("FAIL: octal with underscores");
    else if ('hF_F_ != 255) $display("FAIL: trailing underscore");
    else $display("PASS");
    $finish;
  end
endmodule
