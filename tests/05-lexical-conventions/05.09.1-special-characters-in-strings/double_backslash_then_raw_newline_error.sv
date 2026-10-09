/*
:section: 5.9.1 Special characters in strings
:summary: A double backslash before a newline is a literal backslash, so the newline is
  unescaped and illegal.
:type: parse
:should_fail_because: the \\ is a backslash character, so the following newline is unescaped
*/
module top;
  string s = "end\\
next";
endmodule
