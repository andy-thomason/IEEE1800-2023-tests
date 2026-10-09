/*
:section: 13.5.2 Pass by reference
:summary: A net may not be passed as a ref argument.
:type: elaboration
:should_fail_because: a net is passed by reference
*/
module top;
  wire [3:0] w;
  task automatic t(ref logic [3:0] v); endtask
  initial t(w);
endmodule
