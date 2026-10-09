/*
:section: 35.7 Exported functions
:summary: An exported subroutine must be declared in the scope containing its export
  declaration.
:type: elaboration
:should_fail_because: the exported function is not declared in the scope
*/
module top;
  export "DPI-C" function not_declared_here;
endmodule
