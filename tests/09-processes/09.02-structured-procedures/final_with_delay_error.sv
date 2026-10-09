/*
:section: 9.2.3 Final procedures
:summary: A final procedure must not contain a delay control.
:type: elaboration
:should_fail_because: a final procedure contains a delay
*/
module top;
  final begin
    #1 $display("late");
  end
endmodule
