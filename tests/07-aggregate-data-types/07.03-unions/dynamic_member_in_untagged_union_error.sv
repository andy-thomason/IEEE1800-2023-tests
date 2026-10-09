/*
:section: 7.3.2 Tagged unions
:summary: An untagged union cannot contain a dynamic array member.
:type: elaboration
:should_fail_because: a dynamic array is a member of an untagged union
*/
module top;
  union { int list []; int one; } u;
endmodule
