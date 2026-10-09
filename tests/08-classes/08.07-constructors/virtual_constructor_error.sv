/*
:section: 8.8 Typed constructor calls
:summary: A class constructor may not be declared virtual.
:type: elaboration
:should_fail_because: the constructor is declared virtual
*/
module top;
  class odd_c;
    virtual function new();
    endfunction
  endclass
endmodule
