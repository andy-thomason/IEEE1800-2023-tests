/*
:section: 8.8 Typed constructor calls
:summary: A class constructor may not be declared static.
:type: elaboration
:should_fail_because: the constructor is declared static
*/
module top;
  class odd_c;
    static function new();
    endfunction
  endclass
endmodule
