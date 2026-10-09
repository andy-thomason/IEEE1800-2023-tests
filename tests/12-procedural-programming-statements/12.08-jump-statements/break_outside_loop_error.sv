/*
:section: 12.8 Jump statements
:summary: break is only permitted inside a loop body.
:type: elaboration
:should_fail_because: break is used outside a loop
*/
module top;
  initial begin
    break;
  end
endmodule
