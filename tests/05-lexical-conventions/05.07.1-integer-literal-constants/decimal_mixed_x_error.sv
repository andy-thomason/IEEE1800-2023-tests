/*
:section: 5.7.1 Integer literal constants
:summary: A decimal literal cannot mix numeric digits with x or z digits.
:type: parse
:should_fail_because: the decimal digits mix a numeral with an x digit
*/
module top;
  logic [7:0] v = 8'd4x;
endmodule
