/*
:section: 5.9 String literals
:summary: A plain quoted string cannot span lines without a backslash before the newline.
:type: parse
:should_fail_because: the quoted string contains an unescaped newline
*/
module top;
  string s = "first line
second line";
endmodule
