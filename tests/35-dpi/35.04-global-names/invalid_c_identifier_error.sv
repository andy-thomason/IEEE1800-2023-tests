/*
:section: 35.5.4 Import declarations
:summary: A DPI linkage name must be a valid C identifier, so one starting with a digit is
  illegal.
:type: elaboration
:should_fail_because: the linkage name 1bad does not start with a letter or underscore
*/
module top;
  import "DPI-C" \1bad = function int bad_name();
endmodule
