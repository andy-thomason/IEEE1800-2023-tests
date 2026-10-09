/*
:section: 6.22.2 Equivalent types
:summary: A ref argument of type integer cannot bind to an int variable, as they are not
  equivalent.
:type: elaboration
:should_fail_because: int (2-state) is not equivalent to integer (4-state), as a ref argument requires
*/
module top;
  function automatic void touch(ref integer v);
    v = 1;
  endfunction
  int two_state;
  initial touch(two_state);
endmodule
