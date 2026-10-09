/*
:section: 22.3 `resetall
:summary: Placing `resetall inside a module or other design element is illegal.
:type: parse
:should_fail_because: `resetall appears inside a module
*/
module top;
`resetall
endmodule
