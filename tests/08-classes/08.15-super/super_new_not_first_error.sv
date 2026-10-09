/*
:section: 8.15 Super
:summary: Calling super.new anywhere other than as the first constructor statement is illegal.
:type: elaboration
:should_fail_because: super.new is not the first statement of the constructor
*/
module top;
  class a_c; function new(int v); endfunction endclass
  class b_c extends a_c;
    int x;
    function new();
      x = 1;
      super.new(5);
    endfunction
  endclass
endmodule
