/*
:section: 5.6.1 Escaped identifiers
:summary: Escaped identifiers may include any printable non-space ASCII character, such as
  operators and braces.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int \data+1 = 10;
  int \#count = 20;
  int \{x,y} = 30;
  int \path/to/net = 40;
  int \~!@%^&*()=<>? = 50;
  int plain7 = 60;
  initial begin
    check(\data+1 + \#count == 30, "escaped identifiers with operator characters");
    check(\{x,y} == 30, "escaped identifier with braces and a comma");
    check(\path/to/net == 40, "escaped identifier with slashes");
    check(\~!@%^&*()=<>? == 50, "escaped identifier made of punctuation");
    check(\plain7 == 60, "\\plain7 did not name the same object as plain7");
    \plain7 = 61;
    check(plain7 == 61, "assignment through \\plain7 did not change plain7");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
