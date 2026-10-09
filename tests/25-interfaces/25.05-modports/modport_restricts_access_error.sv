/*
:section: 25.10 Access to interface objects
:summary: Through a modport port, a module may not access interface signals that the modport
  omits.
:type: elaboration
:should_fail_because: hidden is not listed in the modport used for the port
*/
interface hs_if;
  logic req, hidden;
  modport producer(output req);
endinterface
module prod(hs_if.producer p);
  initial p.hidden = 1;
endmodule
module top;
  hs_if link();
  prod u(.p(link));
endmodule
