/*
:section: 35.5.5 Function result
:summary: Imported DPI functions may return byte, shortint, longint, real, chandle, string and
  similar small types.
:dpi: function_result_types.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function byte r_byte();
  import "DPI-C" function shortint r_shortint();
  import "DPI-C" function longint r_longint();
  import "DPI-C" function real r_real();
  import "DPI-C" function shortreal r_shortreal();
  import "DPI-C" function string r_string();
  import "DPI-C" function bit r_bit();
  initial begin
    check(r_byte() == -5, "byte");
    check(r_shortint() == -30000, "shortint");
    check(r_longint() == 64'h1_0000_0001, "longint");
    check(r_real() == 2.5, "real");
    check(r_shortreal() == 0.75, "shortreal (C float)");
    check(r_string() == "from C", "string");
    check(r_bit() == 1'b1, "bit");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
