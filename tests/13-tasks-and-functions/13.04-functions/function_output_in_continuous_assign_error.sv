/*
:section: 13.4.1 Return values and void functions
:summary: A function having an output argument may not be called in a continuous assignment.
:type: elaboration
:should_fail_because: a function with an output argument is called in a continuous assignment
*/
module top;
  function int split(input int v, output int hi);
    hi = v >> 8;
    return v & 255;
  endfunction
  int hi_part;
  wire [7:0] w;
  assign w = split(300, hi_part);
endmodule
