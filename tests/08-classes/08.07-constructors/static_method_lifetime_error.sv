/*
:section: 8.7 Constructors
:summary: Class methods must have automatic lifetime; declaring one with static lifetime is
  illegal.
:type: parse
:should_fail_because: a class method is declared with a static lifetime
*/
module top;
  class counter_c;
    function static int bump();
      return 1;
    endfunction
  endclass
endmodule
