/*
:section: 23.3.2.3 Connecting module instance using implicit named port connections (.name)
:summary: An implicit .name connection is illegal when no matching identifier exists in the
  instantiating scope.
:type: elaboration
:should_fail_because: .a is used but no a is declared in the instantiating scope
*/
module m(input a); endmodule
module top;
  m u(.a);
endmodule
