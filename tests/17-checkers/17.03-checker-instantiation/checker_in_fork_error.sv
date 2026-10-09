/*
:section: 17.3 Checker instantiation
:summary: Instantiating a checker inside a fork-join block is illegal.
:type: elaboration
:should_fail_because: a checker is instantiated inside fork-join
*/
checker any_chk (logic a);
endchecker
module top;
  logic a;
  initial fork
    any_chk u(a);
  join
endmodule
