/*
:section: 25.3.3 Interface example using a generic bundle
:summary: A generic interface port must be connected by name, not with the implicit .name form.
:type: elaboration
:should_fail_because: a generic interface port is connected with .name
*/
interface a_if; int v; endinterface
module reader(interface port);
endmodule
module top;
  a_if port();
  reader r(.port);
endmodule
