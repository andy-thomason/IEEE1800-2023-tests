/*
:section: 23.3.3.4 Port connection rules for interfaces
:summary: A port of a named interface type must connect to an instance of exactly that
  interface.
:type: elaboration
:should_fail_because: a bus_b interface is connected to a bus_a port
*/
interface bus_a; logic x; endinterface
interface bus_b; logic x; endinterface
module m(bus_a p); endmodule
module top;
  bus_b inst();
  m u(.p(inst));
endmodule
