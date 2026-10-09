/*
:section: 5.4 Comments
:summary: Block comments cannot nest; an inner closing delimiter ends the whole comment.
:type: parse
:should_fail_because: the first terminator closes the outer comment, leaving a stray
  terminator token in the module body
*/
module top;
  /* outer /* inner */ still outer? */
endmodule
