/*
:section: 3.12.1 Compilation units
:summary: Compilation-unit declarations are outside the $root hierarchy, so $root.name cannot
  reach them.
:type: elaboration
:should_fail_because: compilation-unit items are not part of the $root hierarchy
*/
int hidden_value = 1;

module top;
  int copy;
  initial copy = $root.hidden_value;
endmodule
