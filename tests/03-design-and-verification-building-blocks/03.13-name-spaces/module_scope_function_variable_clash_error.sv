/*
:section: 3.13 Name spaces
:summary: Inside a module, a variable and a function cannot have the same name.
:type: elaboration
:should_fail_because: a variable and a function share the module name space
*/
module top;
  int compute;
  function automatic int compute();
    return 3;
  endfunction
endmodule
