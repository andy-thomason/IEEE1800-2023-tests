/*
:section: 25.5.4 Modport expressions
:summary: A modport expression port that is a constant cannot have direction output.
:type: elaboration
:should_fail_because: an output modport expression is a constant
*/
interface const_if;
  modport mp(output .k(5));
endinterface
module w(const_if.mp p);
  initial p.k = 1;
endmodule
module top;
  const_if u();
  w inst(.p(u));
endmodule
