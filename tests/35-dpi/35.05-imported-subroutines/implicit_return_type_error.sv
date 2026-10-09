/*
:section: 35.5.5 Function result
:summary: An imported DPI function must declare a return type or void explicitly.
:type: parse
:should_fail_because: the import has no return type
*/
module top;
  import "DPI-C" function no_type(input int x);
endmodule
