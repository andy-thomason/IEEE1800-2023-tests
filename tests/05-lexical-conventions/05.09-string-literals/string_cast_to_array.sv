/*
:section: 5.9 String literals
:summary: A string literal may be cast to packed or unpacked array types using assignment rules.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef byte four_bytes_t [4];
  typedef logic [31:0] word_t;
  four_bytes_t fb;
  word_t w;
  initial begin
    fb = four_bytes_t'("wx");
    check(fb[0] == "w" && fb[1] == "x" && fb[2] == 0 && fb[3] == 0, "unpacked cast is not left justified");
    w = word_t'("AB");
    check(w === 32'h0000_4142, $sformatf("packed cast = %h", w));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
