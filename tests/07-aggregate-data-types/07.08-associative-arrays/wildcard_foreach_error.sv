/*
:section: 7.8.1 Wildcard index type
:summary: A wildcard-indexed associative array cannot be iterated with foreach.
:type: elaboration
:should_fail_because: foreach is used on a wildcard-indexed associative array
*/
module top;
  int any_key [*];
  initial foreach (any_key[k]) $display(k);
endmodule
