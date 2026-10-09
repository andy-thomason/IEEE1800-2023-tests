/*
:section: 27.4 Loop generate constructs
:summary: Two loop generate constructs in one scope may not share a block name.
:type: elaboration
:should_fail_because: two loop generate constructs use the block name lane
*/
module top;
  for (genvar g = 0; g < 2; g++) begin : lane
  end
  for (genvar g = 2; g < 4; g++) begin : lane
  end
endmodule
