/*
:section: 3.13 Name spaces
:summary: A module and an interface cannot share the same definition name.
:type: elaboration
:should_fail_because: a module and an interface share the definitions name space
*/
module gadget;
endmodule

interface gadget;
endinterface

module top;
endmodule
