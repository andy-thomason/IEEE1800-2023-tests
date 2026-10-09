/*
:section: 8.17 Chaining constructors
:summary: A subclass that passes base arguments in its extends clause must not also call
  super.new.
:type: elaboration
:should_fail_because: the subclass calls super.new although the extends specifier gives arguments
*/
module top;
  class base_c; function new(int width); endfunction endclass
  class sub_c extends base_c(4);
    function new();
      super.new(4);
    endfunction
  endclass
endmodule
