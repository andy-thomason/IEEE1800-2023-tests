/*
:section: 8.26 Interface classes
:summary: An interface class may not declare data properties.
:type: elaboration
:should_fail_because: an interface class declares a property
*/
module top;
  interface class bad_ic;
    int count;
  endclass
endmodule
