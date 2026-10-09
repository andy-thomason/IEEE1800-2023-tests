/*
:section: 3.13 Name spaces
:summary: Two package declarations sharing the same name are illegal.
:type: elaboration
:should_fail_because: two packages are both named settings
*/
package settings;
  int a = 1;
endpackage

package settings;
  int b = 2;
endpackage

module top;
endmodule
