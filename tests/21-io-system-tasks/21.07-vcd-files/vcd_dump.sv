/*
:section: 21.7.1 Creating 4-state VCD file
:summary: $dumpfile and $dumpvars produce a VCD file containing header definitions, variable
  declarations and time-stamped changes.
:flags-verilator: --trace
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] count = 0;
  logic flag = 0;
  int fd;
  string line;
  bit saw_enddefs = 0, saw_var = 0, saw_time = 0;
  initial begin
    $dumpfile("waves.vcd");
    $dumpvars(0, top);
    #5 count = 3;
    #5 flag = 1;
    #1 $dumpflush;
    fd = $fopen("waves.vcd", "r");
    check(fd != 0, "VCD file was not created");
    while ($fgets(line, fd)) begin
      if (line.substr(0, 14) == "$enddefinitions") saw_enddefs = 1;
      if (line.substr(0, 3) == "$var") saw_var = 1;
      if (line == "#10\n") saw_time = 1;
    end
    $fclose(fd);
    check(saw_var && saw_enddefs && saw_time, $sformatf("VCD content: var=%0d enddefinitions=%0d #10=%0d", saw_var, saw_enddefs, saw_time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
