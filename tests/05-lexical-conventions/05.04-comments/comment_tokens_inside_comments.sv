/*
:section: 5.4 Comments
:summary: A // sequence has no effect within block comments, and block delimiters have no effect
  after //.
:description: A block comment containing a line-comment token must still end at its
  terminator, and a block-comment opener inside a line comment must be ignored.
*/
module top;
  int value = 1;
  initial begin
    /* the next token sequence // is ordinary text here */ value = value + 10;
    // an opener /* here starts nothing
    value = value + 100;
    if (value != 111) $display("FAIL: value is %0d, expected 111", value);
    else $display("PASS");
    $finish;
  end
endmodule
