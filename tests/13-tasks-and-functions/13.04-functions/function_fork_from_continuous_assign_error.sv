/*
:section: 13.4.4 Background processes spawned by function calls
:summary: A function that forks a process may not be invoked from a continuous assignment.
:type: simulation
:should_fail_because: a function that spawns a process is called from a continuous assignment
*/
module top;
  function int spawn();
    fork #1 $display("spawned"); join_none
    return 1;
  endfunction
  wire w;
  assign w = spawn();
  initial #2 $finish;
endmodule
