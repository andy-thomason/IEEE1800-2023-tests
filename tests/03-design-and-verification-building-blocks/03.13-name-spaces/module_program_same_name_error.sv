/*
:section: 3.13 Name spaces
:summary: A module and a program cannot share the same definition name.
:type: elaboration
:should_fail_because: a module and a program share the definitions name space
*/
module runner;
endmodule

program runner;
endprogram

module top;
endmodule
