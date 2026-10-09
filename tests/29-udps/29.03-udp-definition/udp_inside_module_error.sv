/*
:section: 29.3 UDP definition
:summary: A primitive definition must not be nested inside a module body.
:type: parse
:should_fail_because: a UDP is defined inside a module
*/
module top;
  primitive inner (y, a);
    output y;
    input a;
    table
      0 : 1;
      1 : 0;
    endtable
  endprimitive
endmodule
