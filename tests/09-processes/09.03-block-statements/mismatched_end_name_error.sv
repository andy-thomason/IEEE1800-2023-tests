/*
:section: 9.3.4 Block names
:summary: The name given after end must equal the block's opening name.
:type: parse
:should_fail_because: the name after end differs from the block name
*/
module top;
  initial begin : first_name
  end : other_name
endmodule
