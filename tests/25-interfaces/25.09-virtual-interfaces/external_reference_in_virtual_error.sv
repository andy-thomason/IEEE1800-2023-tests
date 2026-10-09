/*
:section: 25.9 Virtual interfaces
:summary: An interface with upward hierarchical references may not be used to declare a virtual
  interface.
:type: elaboration
:should_fail_because: the interface used for the virtual interface makes an upward hierarchical reference
*/
interface peek_if;
  logic copy;
  assign copy = top.source;
endinterface
module top;
  logic source;
  peek_if p();
  virtual peek_if v;
endmodule
