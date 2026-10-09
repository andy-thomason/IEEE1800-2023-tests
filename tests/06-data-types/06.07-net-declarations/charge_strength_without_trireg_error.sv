/*
:section: 6.7 Net declarations
:summary: Charge strength keywords such as small are only legal on trireg nets, not wire.
:type: parse
:should_fail_because: a charge strength is used with wire
*/
module top;
  wire (small) w;
endmodule
