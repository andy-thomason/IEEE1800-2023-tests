/*
:section: 10.11 Net aliasing
:summary: Nets joined by alias must share the same net type, so wand and wor cannot be aliased.
:type: elaboration
:should_fail_because: a wand and a wor net are aliased
*/
module top;
  wand [3:0] a;
    wor [3:0] b;
    alias a = b;
endmodule
