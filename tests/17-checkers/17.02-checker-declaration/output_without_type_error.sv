/*
:section: 17.2 Checker declaration
:summary: A checker formal argument with an explicit direction must also declare a data type.
:type: elaboration
:should_fail_because: checker formal arguments with directions omit their types
*/
checker typed_chk (input a, output b);
endchecker
module top;
endmodule
