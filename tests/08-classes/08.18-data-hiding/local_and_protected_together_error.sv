/*
:section: 8.19 Constant class properties
:summary: Declaring a class member as both local and protected is an error.
:type: parse
:should_fail_because: a member is both local and protected
*/
module top;
  class confused_c;
    local protected int both;
  endclass
endmodule
