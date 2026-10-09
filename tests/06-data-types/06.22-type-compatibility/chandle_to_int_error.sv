/*
:section: 6.22.5 Type incompatible
:summary: Assigning a chandle to an integral variable is illegal because the types are
  incompatible.
:type: elaboration
:should_fail_because: chandles are type incompatible with integral types
*/
  module top;
    chandle c;
longint i;
initial i = c;
  endmodule
