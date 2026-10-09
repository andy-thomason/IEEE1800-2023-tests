/*
:section: 18.5.12 Constraint guards
:summary: A guard such as next != null is evaluated first and decides whether the guarded
  constraint exists.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class node_c;
    rand int value;
    node_c next;
    constraint order { if (next != null) value < next.value; value inside {[0:100]}; }
  endclass
  node_c head = new, tail = new;
  int bad = 0;
  initial begin
    tail.value = 50;
    head.next = tail;
    repeat (50) if (!head.randomize() || head.value >= 50) bad++;
    check(bad == 0, "guarded constraint");
    check(tail.randomize() == 1, "a null guard was not evaluated before solving");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
