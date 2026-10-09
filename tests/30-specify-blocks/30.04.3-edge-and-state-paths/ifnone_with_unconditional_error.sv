/*
:section: 30.4.4.4 The ifnone condition
:summary: A path cannot have both an ifnone version and an unconditional version at once.
:type: elaboration
:should_fail_because: the path has both ifnone and an unconditional delay
:flags-icarus: -gspecify
*/
module dut(input a, output y);
  buf b(y, a);
  specify
    ifnone (a => y) = 4;
    (a => y) = 2;
  endspecify
endmodule
  module top;
  endmodule
