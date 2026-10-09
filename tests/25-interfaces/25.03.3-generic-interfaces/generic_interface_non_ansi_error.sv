/*
:section: 25.3.3 Interface example using a generic bundle
:summary: A generic interface port cannot be declared using non-ANSI port list style.
:type: parse
:should_fail_because: a generic interface port is declared in non-ANSI style
*/
interface a_if; int v; endinterface
module reader(port);
  interface port;
endmodule
module top;
  a_if ai();
  reader r(.port(ai));
endmodule
