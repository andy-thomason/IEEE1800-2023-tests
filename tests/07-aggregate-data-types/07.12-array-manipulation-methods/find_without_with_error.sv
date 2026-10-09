/*
:section: 7.12.1 Array locator methods
:summary: Calling the find locator method without a with clause is illegal.
:type: elaboration
:should_fail_because: find has no with clause
*/
module top;
  int vals [3] = '{1, 2, 3};
  int r [$];
  initial r = vals.find(x);
endmodule
