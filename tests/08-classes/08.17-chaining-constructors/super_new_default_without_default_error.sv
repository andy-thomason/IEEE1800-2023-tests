/*
:section: 8.17 Chaining constructors
:summary: Calling super.new(default) is illegal unless default appears in the constructor's own
  argument list.
:type: elaboration
:should_fail_because: super.new(default) is used without default in the argument list
*/
module top;
  class base_c; function new(int width = 1); endfunction endclass
  class sub_c extends base_c;
    function new(int depth);
      super.new(default);
    endfunction
  endclass
endmodule
