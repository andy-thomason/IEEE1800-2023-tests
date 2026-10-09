/*
:section: 8.19 Constant class properties
:summary: An instance constant may be set only once, inside the class constructor, not in other
  methods.
:type: elaboration
:should_fail_because: an instance constant is assigned outside the constructor
*/
module top;
  class limits_c;
    const int serial;
    function void set(int s); serial = s; endfunction
  endclass
endmodule
