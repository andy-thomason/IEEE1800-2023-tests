/*
:section: 8.20 Virtual methods
:summary: Using the :extends specifier on a method that overrides no virtual base method is an
  error.
:type: elaboration
:should_fail_because: :extends is used where no virtual base method exists
*/
module top;
  class a_c; function void f(); endfunction endclass
    class b_c extends a_c; function :extends void f(); endfunction endclass
endmodule
