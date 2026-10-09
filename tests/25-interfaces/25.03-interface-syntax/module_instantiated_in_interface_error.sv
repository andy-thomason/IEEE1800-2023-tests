/*
:section: 25.3 Interface syntax
:summary: A module may not be instantiated inside an interface.
:type: elaboration
:should_fail_because: a module is instantiated inside an interface
*/
module leaf; endmodule
interface outer_if;
  leaf u();
endinterface
module top;
  outer_if u();
endmodule
