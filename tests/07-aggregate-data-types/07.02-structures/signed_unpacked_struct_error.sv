/*
:section: 7.2.1 Packed structures
:summary: An unpacked structure cannot be declared signed.
:type: parse
:should_fail_because: an unpacked struct is declared signed
*/
module top;
  typedef struct signed { int count; logic flag; } bad_t;
endmodule
