/*
:section: 3.13 Name spaces
:summary: Declaring one name twice within the same named block is illegal.
:type: elaboration
:should_fail_because: scratch is declared twice in the same block
*/
module top;
  initial begin : work
    int scratch;
    int scratch;
  end
endmodule
