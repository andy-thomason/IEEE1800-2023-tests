/*
:section: 8.25.1 Class scope resolution operator for parameterized classes
:summary: An unspecialized parameterized class name cannot prefix :: outside that class and its
  extern definitions.
:type: elaboration
:should_fail_because: holder_c:: is used outside the class without a specialization
*/
module top;
  class holder_c #(int p = 1);
  endclass
  int x = holder_c::p;
endmodule
