/*
:section: H.10.1.2 Canonical representation of packed arrays
:summary: svDpiVersion returns a string naming the supported DPI canonical representation, such
  as 1800-2005.
:dpi: dpi_version.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function string version();
  initial begin
    check(version() == "1800-2005", $sformatf("svDpiVersion returned '%s'", version()));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
