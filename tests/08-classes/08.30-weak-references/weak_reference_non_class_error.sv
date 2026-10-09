/*
:section: 8.30.1 Overview
:summary: weak_reference must be specialized with a class type; using int is a compile error.
:type: elaboration
:should_fail_because: weak_reference is specialized with int
*/
module top;
  weak_reference #(int) w;
endmodule
