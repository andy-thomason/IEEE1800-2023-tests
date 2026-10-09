/*
:section: 7.4.5 Indexing and slicing of arrays
:summary: Slices and part-selects need a constant width but may start at a variable position.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [31:0] bits = 32'hDEADBEEF;
  bit [3:0][7:0] packed_bytes = 32'h11223344;
  int unpacked [8];
  int window [3];
  int pos;
  initial begin
    foreach (unpacked[i]) unpacked[i] = i * i;
    pos = 8;
    check(bits[pos +: 8] == 8'hBE && bits[pos + 7 -: 8] == 8'hBE, "variable-position part-selects");
    check(packed_bytes[2:1] == 16'h2233, "slice of a packed array is packed");
    pos = 3;
    window = unpacked[pos +: 3];
    check(window[0] == 9 && window[2] == 25, "variable-position slice of an unpacked array");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
