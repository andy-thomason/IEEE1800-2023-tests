// Compilation-unit time unit for this file only.
timeunit 1ns;
timeprecision 1ns;

module other_unit_probe(output logic done);
  initial begin done = 0; #4 done = 1; end
endmodule
