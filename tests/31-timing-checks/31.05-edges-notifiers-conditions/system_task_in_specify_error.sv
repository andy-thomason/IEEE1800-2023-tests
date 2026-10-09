/*
:section: 31.2 Overview
:summary: System tasks such as $display are illegal inside a specify block.
:type: parse
:should_fail_because: a system task appears in a specify block
:flags-icarus: -gspecify
*/
module chk(input a, output y);
  assign y = a;
  specify
    $display("not allowed");
  endspecify
endmodule
module top;
  logic a;
  wire y;
  chk u(.a(a), .y(y));
endmodule
