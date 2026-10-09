module unit_probe;
`ifdef DEFINED_IN_FIRST_UNIT
  int leaked = 1;
`else
  int leaked = 0;
`endif
endmodule
