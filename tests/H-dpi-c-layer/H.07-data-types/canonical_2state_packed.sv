/*
:section: H.7.7 Canonical representation of packed arrays
:summary: 2-state packed DPI arguments are passed as 32-bit words with the least significant
  word first.
:dpi: canonical_2state_packed.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function int words_ok(input bit [39:0] v);
  import "DPI-C" function void make_wide(output bit [63:0] v);
  bit [63:0] w;
  initial begin
    check(words_ok(40'hAB_1234_5678) == 1, "input words split LSB-first");
    make_wide(w);
    check(w == 64'hCAFE_0000_0000_BEEF, $sformatf("output assembled from words: %h", w));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
