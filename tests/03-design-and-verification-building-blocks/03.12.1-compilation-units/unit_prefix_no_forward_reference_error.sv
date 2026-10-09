/*
:section: 3.12.1 Compilation units
:summary: Prefixing with $unit:: does not permit referring to a compilation-unit item declared
  afterwards.
:type: elaboration
:should_fail_because: $unit:: does not allow a reference to a later compilation-unit item
*/
function automatic int peek_ahead();
  return $unit::declared_afterwards + 1;
endfunction

int declared_afterwards = 4;

module top;
  initial $display("%0d", peek_ahead());
endmodule
