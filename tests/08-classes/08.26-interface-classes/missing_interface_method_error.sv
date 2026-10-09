/*
:section: 8.26 Interface classes
:summary: A concrete class implementing an interface class must provide every one of its pure
  virtual methods.
:type: elaboration
:should_fail_because: a class implements an interface class without implementing its method
*/
module top;
  interface class putter_ic; pure virtual function void put(int v); endclass
  class empty_c implements putter_ic; endclass
endmodule
