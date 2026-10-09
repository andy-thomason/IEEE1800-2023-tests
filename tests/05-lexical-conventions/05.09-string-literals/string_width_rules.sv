/*
:section: 5.9 String literals
:summary: Strings in wider packed targets are right-aligned with zero padding; narrower targets
  keep the rightmost characters.
:flags-verilator: -Wno-WIDTH
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  bit [39:0] wide = "hi";
  bit [15:0] narrow = "abcd";
  bit [0:2][7:0] packed_chars = "xyz";
  initial begin
    check(wide === 40'h00_0000_6869, $sformatf("\"hi\" in 40 bits = %h", wide));
    check(narrow === "cd", $sformatf("\"abcd\" in 16 bits = %h", narrow));
    check(packed_chars[0] == "x" && packed_chars[2] == "z", "multidimensional packed array of characters");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
