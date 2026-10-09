/*
:section: 25.9 Virtual interfaces
:summary: A virtual interface may not be a member of a union.
:type: elaboration
:should_fail_because: a virtual interface is a union member
*/
interface sig_if(input logic clk);
  logic [7:0] value;
  logic flag;
  modport mon(input value);
endinterface

module top;
  typedef union { virtual sig_if v; int i; } u_t;
  u_t u;
endmodule
