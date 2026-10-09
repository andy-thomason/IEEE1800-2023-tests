/*
:section: 8.19 Constant class properties
:summary: A const class property initialized at its declaration cannot be assigned inside a
  method.
:type: elaboration
:should_fail_because: a global constant property is assigned in a method
*/
module top;
  class limits_c;
    const int ceiling = 100;
    function void raise(); ceiling = 200; endfunction
  endclass
endmodule
