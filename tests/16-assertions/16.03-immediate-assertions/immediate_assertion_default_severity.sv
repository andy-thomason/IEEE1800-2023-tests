/*
:section: 16.3 Immediate assertions
:summary: A failing immediate assertion with no else clause reports an error via $error by
  default.
:type: simulation
:should_fail_because: a failing assertion without an else clause calls $error
:description: $error is expected to give a failing exit status; the message text is tool-specific.
*/
module top;
  initial begin
    assert (1'b0);
    $finish;
  end
endmodule
