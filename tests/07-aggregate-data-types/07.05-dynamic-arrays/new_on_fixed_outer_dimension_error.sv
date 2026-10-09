/*
:section: 7.5.1 New[ ]
:summary: new[] may only initialize arrays whose leftmost unpacked dimension is dynamic.
:type: elaboration
:should_fail_because: new[] initialises an array whose leftmost dimension is fixed
*/
module top;
  int outer_fixed [2][] = new [3];
endmodule
