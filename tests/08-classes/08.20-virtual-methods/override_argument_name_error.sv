/*
:section: 8.20 Virtual methods
:summary: A virtual method override must keep the same argument names as the base prototype.
:type: elaboration
:should_fail_because: the override renames the argument
*/
module top;
  class a_c; virtual function void f(int v); endfunction endclass
    class b_c extends a_c; virtual function void f(int w); endfunction endclass
endmodule
