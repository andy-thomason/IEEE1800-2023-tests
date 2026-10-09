/*
:section: 8.7 Constructors
:summary: A class constructor must not contain a delay or other blocking statement.
:type: elaboration
:should_fail_because: the constructor contains a delay
*/
module top;
  class slow_c;
    function new();
      #1;
    endfunction
  endclass
endmodule
