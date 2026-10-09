/*
:section: 8.26.4 Type usage restrictions
:summary: A class may not list a type parameter in its implements clause.
:type: elaboration
:should_fail_because: a class implements a type parameter
*/
module top;
  interface class putter_ic; pure virtual function void put(int v); endclass
  class wrap_c #(type I = putter_ic) implements I;
    virtual function void put(int v); endfunction
  endclass
endmodule
