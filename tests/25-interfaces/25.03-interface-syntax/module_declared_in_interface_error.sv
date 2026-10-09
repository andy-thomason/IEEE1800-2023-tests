/*
:section: 25.3 Interface syntax
:summary: A module declaration may not appear inside an interface.
:type: elaboration
:should_fail_because: a module is declared inside an interface
*/
interface outer_if;
  module inner; endmodule
endinterface
module top;
  outer_if u();
endmodule
