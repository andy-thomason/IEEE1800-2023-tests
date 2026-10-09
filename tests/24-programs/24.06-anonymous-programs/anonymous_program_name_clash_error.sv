/*
:section: 24.6 Program-wide space and anonymous programs
:summary: An item in an anonymous program clashes with a same-named declaration elsewhere in its
  package.
:type: elaboration
:should_fail_because: calls is declared both inside and outside the anonymous program in one package
*/
package tb_utils;
  program;
    int calls;
  endprogram
  int calls;
endpackage
module top;
endmodule
