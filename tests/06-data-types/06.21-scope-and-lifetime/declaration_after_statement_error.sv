/*
:section: 6.21 Scope and lifetime
:summary: Within a procedural block, all variable declarations must come before any statement.
:type: parse
:should_fail_because: a declaration follows a statement in the block
*/
module top;
  initial begin
    int a;
    a = 1;
    int b;
  end
endmodule
