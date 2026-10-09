/*
:section: 3.13 Name spaces
:summary: In the compilation-unit scope, a variable and a function cannot have the same name.
:type: elaboration
:should_fail_because: a variable and a function share the compilation-unit name space
*/
int measure;

function automatic int measure();
  return 1;
endfunction

module top;
endmodule
