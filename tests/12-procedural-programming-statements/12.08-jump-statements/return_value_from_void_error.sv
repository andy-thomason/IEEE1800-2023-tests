/*
:section: 12.8 Jump statements
:summary: A void function may not return a value with its return statement.
:type: elaboration
:should_fail_because: a void function returns a value
*/
module top;
  function void f();
    return 3;
  endfunction
endmodule
