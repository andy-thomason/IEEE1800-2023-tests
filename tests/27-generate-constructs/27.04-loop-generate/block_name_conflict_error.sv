/*
:section: 27.4 Loop generate constructs
:summary: A loop generate block name must not conflict with another declaration in the scope.
:type: elaboration
:should_fail_because: the generate block name lane is also a variable
*/
module top;
  int lane;
  for (genvar g = 0; g < 2; g++) begin : lane
  end
endmodule
