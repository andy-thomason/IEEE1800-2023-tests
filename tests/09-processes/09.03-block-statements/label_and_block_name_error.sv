/*
:section: 9.3.5 Statement labels
:summary: A begin block may not carry both a statement label and a block name.
:type: parse
:should_fail_because: a begin has both a statement label and a block name
*/
module top;
  initial lbl: begin : nm
  end
endmodule
