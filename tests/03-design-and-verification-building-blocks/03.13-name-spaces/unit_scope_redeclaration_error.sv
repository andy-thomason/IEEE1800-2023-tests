/*
:section: 3.13 Name spaces
:summary: Declaring the same variable twice in the compilation-unit scope is illegal.
:type: elaboration
:should_fail_because: shared_total is declared twice in the compilation-unit scope
*/
int shared_total;
int shared_total;

module top;
endmodule
