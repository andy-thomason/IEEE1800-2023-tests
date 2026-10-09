/*
:section: 8.20 Virtual methods
:summary: Marking a method :initial when it actually overrides a base virtual method is an
  error.
:type: elaboration
:should_fail_because: :initial is used on a virtual override
*/
module top;
  class a_c; virtual function void f(); endfunction endclass
    class b_c extends a_c; function :initial void f(); endfunction endclass
endmodule
