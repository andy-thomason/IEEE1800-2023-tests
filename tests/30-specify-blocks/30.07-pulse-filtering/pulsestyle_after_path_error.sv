/*
:section: 30.7.4.1 On-event versus on-detect pulse filtering
:summary: Naming an output in pulsestyle_ondetect after it already appears in a module path is
  an error.
:type: elaboration
:should_fail_because: pulsestyle_ondetect names y after its path
:flags-icarus: -gspecify
*/
module dut(input a, output y);
  buf b(y, a);
  specify
    (a => y) = 3;
    pulsestyle_ondetect y;
  endspecify
endmodule
  module top;
  endmodule
