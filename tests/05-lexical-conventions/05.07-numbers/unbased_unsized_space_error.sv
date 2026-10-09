/*
:section: 5.7 Numbers
:summary: An unbased unsized literal like '1 cannot have white space after the apostrophe.
:type: parse
:should_fail_because: the apostrophe is separated from the 1 by a space
*/
module top;
  logic [3:0] v = ' 1;
endmodule
