/*
:section: 31.4.4 $width
:summary: A $width check that supplies a notifier must also supply a non-empty threshold.
:type: parse
:should_fail_because: $width has a notifier but an empty threshold
:flags-icarus: -gspecify
*/
module chk(input clr);
  reg n;
  specify
    $width(negedge clr, 10, , n);
  endspecify
endmodule
module top;
  logic clr;
  chk u(.clr(clr));
endmodule
