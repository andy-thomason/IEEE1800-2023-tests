/*
:section: 11.10.2 String literal value padding and potential problems
:summary: String literals stored into wider vectors are zero-padded on the left, and that
  padding affects comparison and concatenation.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  bit [8*6:1] head, tail;
  bit [8*3:1] three;
  initial begin
    head = "pq";
    tail = "rst";
    check(head == {32'h0, "pq"}, "left padding with zero");
    check({head, tail} != "pqrst", "padded halves do not concatenate to the unpadded literal");
    check({head, tail} == {32'h0, "pq", 24'h0, "rst"}, "padding stays inside a concatenation of padded vectors");
    three = "ab";
    check(three == {8'h00, "ab"}, "short literal is padded to the vector width");
    check("" == 8'h00 && "" != "0", "empty string literal is NUL, not \"0\"");
    check("abc" > "abb", "string literals compare as integers");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
