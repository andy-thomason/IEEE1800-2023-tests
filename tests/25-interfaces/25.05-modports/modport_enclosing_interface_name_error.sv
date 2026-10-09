/*
:section: 25.5 Modports
:summary: A modport in a nested interface must not list a signal belonging to the enclosing
  interface.
:type: elaboration
:should_fail_because: the inner modport lists a signal of the enclosing interface
*/
interface outer_if;
  logic shared;
  interface inner_if;
    logic own;
    modport mp(input own, output shared);
  endinterface
  inner_if in();
endinterface
module top;
  outer_if o();
endmodule
