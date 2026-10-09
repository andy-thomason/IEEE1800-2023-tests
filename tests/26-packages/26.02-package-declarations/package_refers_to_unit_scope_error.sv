/*
:section: 26.2 Package declarations
:summary: A package may not reference a variable from the compilation-unit scope.
:type: elaboration
:should_fail_because: a package refers to a compilation-unit variable
*/
int unit_value = 3;
package bad_pkg;
  int copy = unit_value;
endpackage
module top;
endmodule
