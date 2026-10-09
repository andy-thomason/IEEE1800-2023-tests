/*
:section: 8.13 Inheritance and subclasses
:summary: Deriving a subclass from a class marked final is an error.
:type: elaboration
:should_fail_because: a final class is extended
*/
module top;
  class :final sealed_c; endclass
  class child_c extends sealed_c; endclass
endmodule
