/*
:section: 8.16 Casting
:summary: Assigning a base class handle directly to a subclass variable without $cast is
  illegal.
:type: elaboration
:should_fail_because: a base handle is assigned to a derived variable without $cast
*/
module top;
  class animal_c; endclass
  class dog_c extends animal_c; endclass
  animal_c a = new;
  dog_c d;
  initial d = a;
endmodule
