/*
:section: 8.24 Out-of-block declarations
:summary: An out-of-block method definition must match the extern prototype exactly, including
  argument types.
:type: elaboration
:should_fail_because: the out-of-block declaration changes the argument type
*/
class calc_c;
  extern function int f(int k);
endclass
function int calc_c::f(byte k);
  return k;
endfunction
module top;
endmodule
