/*
:section: 6.20.1 Parameter declaration syntax
:summary: Declaring a localparam inside the #( ) list without assigning it is an error.
:type: parse
:should_fail_because: a localparam in a parameter port list has no value
*/
module holder #(parameter int A = 1, localparam int B);
endmodule

module top;
  holder u();
endmodule
