/*
:section: 13.4 Functions
:summary: A function may not contain a # delay or other timing control.
:type: elaboration
:should_fail_because: a function contains a delay
*/
module top;
  function int slow();
    #1;
    return 1;
  endfunction
endmodule
