/*
:section: 3.13 Name spaces
:summary: A macro redefined in a later file of the same compilation unit takes the new value
  from that point onward.
:files: macro_redefinition_spans_files_probe.svh
*/
`define STAGE_COUNT 2

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int in_first_file = `STAGE_COUNT;
  stage_probe u_probe();
  initial begin
    #1;
    check(in_first_file == 2, $sformatf("first file saw %0d", in_first_file));
    check(u_probe.seen == 6, $sformatf("second file saw %0d", u_probe.seen));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
`define STAGE_COUNT 6
