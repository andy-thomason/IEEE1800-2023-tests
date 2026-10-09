/*
:section: 6.21 Scope and lifetime
:summary: Variables declared in an unnamed block cannot be accessed by hierarchical name.
:type: elaboration
:should_fail_because: a variable in an unnamed block is reached by a hierarchical name
*/
module top;
  initial begin
    static int hidden = 3;
  end
  int copy;
  initial #1 copy = top.hidden;
endmodule
