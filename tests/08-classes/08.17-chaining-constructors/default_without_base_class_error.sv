/*
:section: 8.17 Chaining constructors
:summary: Using default in a constructor argument list is illegal in a class that extends
  nothing.
:type: elaboration
:should_fail_because: default is used in a class that does not extend another
*/
module top;
  class alone_c;
    function new(default);
    endfunction
  endclass
endmodule
