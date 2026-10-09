/*
:section: 8.21 Abstract classes and pure virtual methods
:summary: A concrete subclass must implement every pure virtual method of its abstract parent.
:type: elaboration
:should_fail_because: a non-abstract class does not implement a pure virtual method
*/
module top;
  virtual class shape_c; pure virtual function int area(); endclass
  class blob_c extends shape_c; endclass
endmodule
