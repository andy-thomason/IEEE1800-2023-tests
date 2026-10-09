/*
:section: 10.10.1 Unpacked array concatenations compared with array assignment patterns
:summary: Replication syntax is not allowed inside an unpacked array concatenation.
:type: elaboration
:should_fail_because: replication is used in an unpacked array concatenation
*/
module top;
  int nine [9];
  initial nine = {9{1}};
endmodule
