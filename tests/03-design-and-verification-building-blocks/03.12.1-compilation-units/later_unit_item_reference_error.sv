/*
:section: 3.12.1 Compilation units
:summary: A compilation-unit function cannot refer to a variable that is declared later in the
  unit.
:type: elaboration
:should_fail_because: the function refers to a compilation-unit variable declared after it
*/
function automatic int peek_ahead();
  return declared_afterwards + 1;
endfunction

int declared_afterwards = 4;

module top;
  initial $display("%0d", peek_ahead());
endmodule
