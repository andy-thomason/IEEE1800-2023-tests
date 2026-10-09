/*
:section: 7.9.10 Associative array arguments
:summary: A fixed-size array cannot be passed to an associative array formal argument.
:type: elaboration
:should_fail_because: a fixed-size array is passed to an associative array formal
*/
module top;
  function automatic int count(int m [int]);
    return m.num();
  endfunction
  int fixed [4];
  initial $display(count(fixed));
endmodule
