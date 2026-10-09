/*
:section: 5.9.1 Special characters in strings
:summary: A hex escape in a string must not use x or z as a digit.
:type: parse
:should_fail_because: z is not allowed as a digit of a hex escape
*/
module top;
  string s = "\x4z";
endmodule
