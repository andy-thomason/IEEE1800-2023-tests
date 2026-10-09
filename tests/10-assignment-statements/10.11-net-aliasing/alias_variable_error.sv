/*
:section: 10.11 Net aliasing
:summary: Variables may not appear in an alias statement; only nets can be aliased.
:type: elaboration
:should_fail_because: a variable is used in an alias
*/
module top;
  logic [3:0] v;
    wire [3:0] w;
    alias w = v;
endmodule
