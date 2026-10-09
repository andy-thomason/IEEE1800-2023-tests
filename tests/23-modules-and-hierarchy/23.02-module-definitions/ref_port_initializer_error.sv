/*
:section: 23.2.2.2 ANSI style list of port declarations
:summary: A ref port must not be given an initial value in its declaration.
:type: elaboration
:should_fail_because: a ref port has an initializer
*/
module m(ref int a = 3);
endmodule
module top;
endmodule
