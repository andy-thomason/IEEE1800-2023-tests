/*
:section: 6.20.3 Type parameters
:summary: A defparam statement cannot override a type parameter.
:type: elaboration
:should_fail_because: defparam is used on a type parameter
*/
module holder #(parameter type T = int);
  T value;
endmodule

module top;
  holder u();
  defparam u.T = byte;
endmodule
