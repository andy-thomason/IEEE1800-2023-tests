/*
:section: 8.11 This
:summary: The this handle is illegal inside a static class method.
:type: elaboration
:should_fail_because: this is used inside a static method
*/
module top;
  class holder_c;
    int value;
    static function int peek();
      return this.value;
    endfunction
  endclass
endmodule
