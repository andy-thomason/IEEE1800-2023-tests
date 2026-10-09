/*
:section: 5.12 Attributes
:summary: An attribute value expression must not contain a nested attribute instance.
:type: parse
:should_fail_because: an attribute value contains another attribute instance
*/
module top;
  (* outer = 1 + (* inner *) 2 *) int v;
endmodule
