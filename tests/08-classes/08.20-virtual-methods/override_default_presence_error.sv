/*
:section: 8.20 Virtual methods
:summary: An override must have a default value wherever the base prototype argument has one.
:type: elaboration
:should_fail_because: the override drops the default value
*/
module top;
  class a_c; virtual function void f(int v = 1); endfunction endclass
    class b_c extends a_c; virtual function void f(int v); endfunction endclass
endmodule
