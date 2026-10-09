/*
:section: 8.10 Static methods
:summary: A static method cannot read a non-static class property.
:type: elaboration
:should_fail_because: a static method reads a non-static property
*/
module top;
  class holder_c;
    int value;
    static function int peek();
      return value;
    endfunction
  endclass
endmodule
