/*
:section: 8.21 Abstract classes and pure virtual methods
:summary: Constructing an object of a virtual (abstract) class directly is illegal.
:type: elaboration
:should_fail_because: an abstract class is constructed
*/
module top;
  virtual class shape_c; endclass
  shape_c s;
  initial s = new;
endmodule
