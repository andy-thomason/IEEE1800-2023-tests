/*
:section: 8.20 Virtual methods
:summary: A virtual override must return a matching type or, for class returns, a derived class
  type.
:type: elaboration
:should_fail_because: the override changes the return type to a non-matching type
*/
module top;
  class a_c; virtual function int f(); return 0; endfunction endclass
    class b_c extends a_c; virtual function byte f(); return 0; endfunction endclass
endmodule
