/*
:section: 8.15 Super
:summary: Chaining super.super to reach a grandparent member is not permitted.
:type: elaboration
:should_fail_because: super.super is used
*/
module top;
  class a_c; int count; endclass
  class b_c extends a_c; endclass
  class c_c extends b_c;
    function int up(); return super.super.count; endfunction
  endclass
endmodule
