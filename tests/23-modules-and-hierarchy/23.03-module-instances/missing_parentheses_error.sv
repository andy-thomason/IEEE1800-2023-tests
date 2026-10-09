/*
:section: 23.3.2 Module instantiation syntax
:summary: Every module instantiation requires parentheses, even when the module declares no
  ports.
:type: parse
:should_fail_because: an instantiation has no parentheses
*/
module leaf; endmodule
module top;
  leaf u;
endmodule
