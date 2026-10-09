/*
:section: 8.20 Virtual methods
:summary: A virtual method override must keep the same argument directions as the base
  prototype.
:type: elaboration
:should_fail_because: the override changes the argument direction
*/
module top;
  class a_c; virtual function void f(input int v); endfunction endclass
    class b_c extends a_c; virtual function void f(output int v); endfunction endclass
endmodule
