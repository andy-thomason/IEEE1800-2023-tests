/*
:section: 8.26 Interface classes
:summary: A class with matching methods but no implements clause cannot be assigned to an
  interface class handle.
:type: elaboration
:should_fail_because: a class with matching methods that does not implement the interface class is assigned
  to it
*/
module top;
  interface class putter_ic; pure virtual function void put(int v); endclass
  class lookalike_c; virtual function void put(int v); endfunction endclass
  putter_ic p;
  lookalike_c l = new;
  initial p = l;
endmodule
