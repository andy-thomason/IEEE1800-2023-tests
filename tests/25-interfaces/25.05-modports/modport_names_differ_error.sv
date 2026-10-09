/*
:section: 25.5 Modports
:summary: If both header and instance name a modport, the two modport names must match.
:type: elaboration
:should_fail_because: the header says producer and the instance says consumer
*/
interface hs_if;
  logic req, ack;
  modport producer(output req, input ack);
  modport consumer(input req, output ack);
endinterface
module prod(hs_if.producer p); endmodule
module top;
  hs_if link();
  prod p(.p(link.consumer));
endmodule
