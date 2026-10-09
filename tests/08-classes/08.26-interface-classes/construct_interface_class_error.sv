/*
:section: 8.26.5 Casting and object reference assignment
:summary: Calling new to build an interface class instance is illegal.
:type: elaboration
:should_fail_because: an interface class is constructed
*/
module top;
  interface class putter_ic; pure virtual function void put(int v); endclass
  putter_ic p;
  initial p = new;
endmodule
