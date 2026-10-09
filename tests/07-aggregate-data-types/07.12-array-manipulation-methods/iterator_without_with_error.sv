/*
:section: 7.12 Array manipulation methods
:summary: Naming an iterator argument on an array method without supplying a with clause is
  illegal.
:type: elaboration
:should_fail_because: an iterator argument is given without a with clause
*/
module top;
  int vals [3] = '{1, 2, 3};
  int total;
  initial total = vals.sum(v);
endmodule
