/*
:section: 10.10 Unpacked array concatenation
:summary: An unpacked array concatenation is illegal anywhere except as the source of an
  assignment-like context.
:type: elaboration
:should_fail_because: an unpacked array concatenation is used outside an assignment-like context
*/
module top;
  int three [3] = '{1, 2, 3};
  int n;
  initial n = $size({three, 4});
endmodule
