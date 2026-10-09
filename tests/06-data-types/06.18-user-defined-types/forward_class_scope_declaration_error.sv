/*
:section: 6.18 User-defined types
:summary: Selecting a type through an incomplete forward type prefix is illegal in a variable
  declaration.
:type: elaboration
:should_fail_because: a variable declaration selects a type from an incomplete forward type
*/
module top;
  typedef holder;
  holder::item_t v;
  class holder;
    typedef logic [4:0] item_t;
  endclass
endmodule
