/*
:section: 5.9.1 Special characters in strings
:summary: An octal escape in a string must not use x, z or ? as a digit.
:type: parse
:should_fail_because: ? is a z_digit and is not allowed in an octal escape
*/
module top;
  string s = "\12?";
endmodule
