/*
:section: 26.2 Package declarations
:summary: A package item may not use a hierarchical reference to something declared in a module.
:type: elaboration
:should_fail_because: a package function makes a hierarchical reference into a module
*/
package bad_pkg;
  function automatic int peek(); return top.value; endfunction
endpackage
module top;
  int value;
endmodule
