/*
:section: 13.5.2 Pass by reference
:summary: Assigning to a const ref argument inside the subroutine is a compile error.
:type: elaboration
:should_fail_because: a const ref argument is written
*/
module top;
  function automatic void clear(const ref int v);
    v = 0;
  endfunction
endmodule
