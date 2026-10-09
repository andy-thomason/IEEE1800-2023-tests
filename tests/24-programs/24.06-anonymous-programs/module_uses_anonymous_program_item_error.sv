/*
:section: 24.6 Program-wide space and anonymous programs
:summary: A module may not access a variable that lives in an anonymous program within a
  package.
:type: elaboration
:should_fail_because: a module writes a variable declared in an anonymous program
*/
package tb_utils;
  program;
    int calls;
  endprogram
endpackage
module top;
  initial tb_utils::calls = 1;
endmodule
