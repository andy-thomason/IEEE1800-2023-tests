/*
:section: 6.16.1 Len()
:summary: len returns how many characters a string holds, which is 0 for an empty string.
*/
module top;
  string empty = "";
  string word = "conformance";
  initial begin
    if (empty.len() != 0) $display("FAIL: empty string len is %0d", empty.len());
    else if (word.len() != 11) $display("FAIL: len is %0d, expected 11", word.len());
    else begin
      word = {word, "!"};
      if (word.len() != 12) $display("FAIL: len after append is %0d", word.len());
      else $display("PASS");
    end
    $finish;
  end
endmodule
