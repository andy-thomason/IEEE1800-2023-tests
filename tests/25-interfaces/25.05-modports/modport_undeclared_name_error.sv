/*
:section: 25.5 Modports
:summary: Every name in a modport must be declared in that interface; modports cannot create new
  signals.
:type: elaboration
:should_fail_because: the modport names a signal the interface does not declare
*/
interface hs_if;
  logic req;
  modport producer(output req, input never_declared);
endinterface
module top;
  hs_if link();
endmodule
