/*
:section: 7.10 Queues
:summary: A queue bound must be a positive integer, so [$:0] is illegal.
:type: elaboration
:should_fail_because: the queue bound is not positive
*/
module top;
  int q [$:0];
endmodule
