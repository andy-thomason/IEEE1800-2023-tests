/*
:section: 25.5.4 Modport expressions
:summary: Within one modport, the same port identifier may not be defined twice.
:type: elaboration
:should_fail_because: the port identifier a is defined twice in one modport
*/
interface dup_if;
  logic a, b;
  modport mp(input a, output .a(b));
endinterface
module top;
  dup_if u();
endmodule
