/*
:section: 6.6.7 User-defined nettypes
:summary: A nettype resolution function must return the nettype's data type, not some other
  type.
:type: elaboration
:should_fail_because: the resolution function returns real for an int nettype
*/
module top;
  function automatic real wrong_type(input int drivers []);
    return 0.0;
  endfunction
  nettype int counted_net with wrong_type;
endmodule
