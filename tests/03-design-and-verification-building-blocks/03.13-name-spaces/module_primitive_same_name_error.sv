/*
:section: 3.13 Name spaces
:summary: A module and a UDP primitive cannot share the same definition name.
:type: elaboration
:should_fail_because: a module and a primitive share the definitions name space
*/
primitive inverter (out, in);
  output out;
  input in;
  table
    0 : 1;
    1 : 0;
  endtable
endprimitive

module inverter;
endmodule

module top;
endmodule
