/*
:section: 8.18 Data hiding and encapsulation
:summary: A local class member is not visible inside a subclass.
:type: elaboration
:should_fail_because: a local member is read from a subclass
*/
module top;
  class account_c; local int pin; endclass
    class sub_c extends account_c;
      function int get(); return pin; endfunction
    endclass
endmodule
