/*
:section: 6.7.1 Net declarations with built-in net types
:summary: The reg keyword must not immediately follow a net type keyword such as wire.
:type: parse
:should_fail_because: wire is directly followed by reg
*/
module top;
  wire reg q;
endmodule
