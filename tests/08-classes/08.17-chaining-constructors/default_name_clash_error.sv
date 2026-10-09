/*
:section: 8.17 Chaining constructors
:summary: An extra constructor argument may not share a name with a parent constructor argument
  when default is used.
:type: elaboration
:should_fail_because: an extra argument has the same name as a superclass constructor argument
*/
module top;
  class base_c; function new(int width); endfunction endclass
  class sub_c extends base_c;
    function new(int width, default);
    endfunction
  endclass
endmodule
