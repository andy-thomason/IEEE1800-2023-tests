/*
:section: 15.4.5 Get()
:summary: Retrieving a message from a typeless mailbox into a variable of mismatched type causes
  a run-time error.
:type: simulation
:should_fail_because: an int message is received into a string variable
*/
module top;
  mailbox mb = new;
  string s;
  initial begin
    mb.put(5);
    mb.get(s);
    $display("got a string from an int message: %s", s);
    $finish;
  end
endmodule
