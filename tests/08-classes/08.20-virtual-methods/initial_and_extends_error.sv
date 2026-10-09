/*
:section: 8.20 Virtual methods
:summary: Combining the :initial and :extends specifiers on one method is an error.
:type: elaboration
:should_fail_because: :initial and :extends are combined
*/
module top;
  class a_c; virtual function void f(); endfunction endclass
    class b_c extends a_c; function :initial :extends void f(); endfunction endclass
endmodule
