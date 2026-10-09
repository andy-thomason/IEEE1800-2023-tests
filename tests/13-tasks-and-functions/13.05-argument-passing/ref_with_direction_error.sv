/*
:section: 13.5.2 Pass by reference
:summary: A ref argument may not also carry a direction such as input.
:type: parse
:should_fail_because: ref is combined with input
*/
module top;
  task automatic t(ref input int v);
  endtask
endmodule
