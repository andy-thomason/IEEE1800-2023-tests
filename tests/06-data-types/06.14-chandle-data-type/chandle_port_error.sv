/*
:section: 6.14 Chandle data type
:summary: A module port must not have the chandle type.
:type: elaboration
:should_fail_because: a port has the chandle type
*/
module holder(input chandle h);
endmodule
module top;
  chandle c;
  holder u(.h(c));
endmodule
