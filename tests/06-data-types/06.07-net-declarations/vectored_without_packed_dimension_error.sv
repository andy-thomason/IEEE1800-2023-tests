/*
:section: 6.7 Net declarations
:summary: The vectored keyword is illegal on a net lacking a packed range.
:type: parse
:should_fail_because: vectored is used on a scalar net
*/
module top;
  wire vectored w;
endmodule
