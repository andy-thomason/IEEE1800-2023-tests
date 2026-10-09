/*
:section: 10.3.1 The net declaration assignment
:summary: An interconnect net cannot be given an assignment in its declaration.
:type: parse
:should_fail_because: an interconnect net has a declaration assignment
*/
module top;
  interconnect link = 1'b1;
endmodule
