/*
:section: 7.9.4 First()
:summary: Traversal methods such as first() cannot be called on wildcard-indexed associative
  arrays.
:type: elaboration
:should_fail_because: first() is called on a wildcard-indexed array
*/
module top;
  int any_key [*];
  int k;
  initial void'(any_key.first(k));
endmodule
