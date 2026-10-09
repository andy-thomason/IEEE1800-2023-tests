/*
:section: 24.5 Blocking tasks in cycle/event mode
:summary: A design module may not call a task declared inside a program.
:type: elaboration
:should_fail_because: a module calls a task declared in a program
*/
program p;
  task automatic poke(); endtask
endprogram
module top;
  p u();
  initial u.poke();
endmodule
