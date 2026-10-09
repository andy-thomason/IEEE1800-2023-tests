/*
:section: 8.24 Out-of-block declarations
:summary: Providing two out-of-block bodies for the same extern method is an error.
:type: elaboration
:should_fail_because: two out-of-block bodies are given for one extern method
*/
class calc_c;
  extern function int f();
endclass
function int calc_c::f(); return 1; endfunction
function int calc_c::f(); return 2; endfunction
module top;
endmodule
