/*
:section: 6.22.5 Type incompatible
:summary: A class handle cannot be assigned to an int because the types are incompatible.
:type: elaboration
:should_fail_because: class handles are type incompatible with int
*/
  module top;
    class thing; endclass
thing h;
int i;
initial i = h;
  endmodule
