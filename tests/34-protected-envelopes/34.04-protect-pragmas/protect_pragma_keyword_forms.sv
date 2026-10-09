/*
:section: 34.4 Protect pragma directives
:summary: Various `pragma protect keywords and expressions are accepted and do not disturb
  surrounding code.
:description: Envelope keywords without a begin/begin_protected do not create an envelope; the
  directives must still be accepted.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  `pragma protect author = "Example Author", author_info = "unit test"
  `pragma protect encoding = (enctype = "base64", line_length = 76, bytes = 12)
  `pragma protect data_method = "aes128-cbc"
  `pragma protect comment = "cleartext note"
  `pragma protect reset
  int value = 5;
  initial begin
    #1;
    check(value == 5, "protect pragma directives outside an envelope leave the source unchanged");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
