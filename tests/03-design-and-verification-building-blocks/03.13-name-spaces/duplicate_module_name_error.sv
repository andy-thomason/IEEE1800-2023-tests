/*
:section: 3.13 Name spaces
:summary: Two module definitions with the same name are not allowed.
:type: elaboration
:should_fail_because: two modules are both named widget
*/
module widget;
endmodule

module widget;
  int extra;
endmodule

module top;
  widget u_widget();
endmodule
