/*
:section: 8.20 Virtual methods
:summary: A subclass may not override a base method declared :final.
:type: elaboration
:should_fail_because: a :final method is overridden
*/
module top;
  class a_c; virtual function :final void f(); endfunction endclass
    class b_c extends a_c; virtual function void f(); endfunction endclass
endmodule
