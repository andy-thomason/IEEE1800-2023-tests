/*
:section: 7.3 Unions
:summary: A void member is allowed only in a tagged union.
:type: elaboration
:should_fail_because: a void member is declared in an untagged union
*/
module top;
  union { void nothing; int value; } u;
endmodule
