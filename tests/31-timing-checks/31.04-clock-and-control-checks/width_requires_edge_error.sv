/*
:section: 31.4.4 $width
:summary: $width requires an edge-qualified reference event; a plain signal is a compile error.
:type: elaboration
:should_fail_because: $width is given a reference event without an edge
:flags-icarus: -gspecify
*/
module chk(input clr);
  specify
    $width(clr, 10);
  endspecify
endmodule
module top;
  logic clr;
  chk u(.clr(clr));
endmodule
