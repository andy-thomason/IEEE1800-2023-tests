/*
:section: 16.4 Deferred assertions
:summary: Each action of a deferred assertion must be a single subroutine call.
:type: elaboration
:should_fail_because: the action block of a deferred assertion is not a subroutine call
*/
module top;
  int fails;
  logic a;
  always_comb assert #0 (a) else fails = fails + 1;
endmodule
