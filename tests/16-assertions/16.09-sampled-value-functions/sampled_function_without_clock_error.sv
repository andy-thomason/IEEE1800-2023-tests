/*
:section: 16.9.3 Sampled value functions
:summary: Calling $rose with no explicit clock and no inferable clock context is illegal.
:type: elaboration
:should_fail_because: $rose is used where no clock can be inferred
*/
module top;
  logic a;
  wire r;
  assign r = $rose(a);
endmodule
