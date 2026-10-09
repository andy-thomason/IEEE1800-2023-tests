/*
:section: 3.13 Name spaces
:summary: One module cannot declare the same identifier as both a variable and a net.
:type: elaboration
:should_fail_because: ready is declared as both a variable and a net in one module
*/
module top;
  logic ready;
  wire ready;
endmodule
