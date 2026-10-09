/*
:section: 5.6 Identifiers, keywords, and system names
:summary: A reserved keyword like while cannot serve as a user identifier.
:type: parse
:should_fail_because: while is a keyword
*/
module top;
  int while;
endmodule
