/*
:section: 6.24.1 Cast operator
:summary: Casting an unpacked struct to bits and back preserves every member value without loss.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct { bit [3:0] tag; byte value; bit [2:0] mode; } rec_t;
  typedef bit [$bits(rec_t) - 1:0] rec_bits_t;
  rec_t a, b;
  rec_bits_t bits;
  initial begin
    a.tag = 4'hA; a.value = 8'h5C; a.mode = 3'd3;
    bits = rec_bits_t'(a);
    check($bits(bits) == 15, "struct width");
    check(bits === {4'hA, 8'h5C, 3'd3}, $sformatf("bits = %h; the first field should be in the MSBs", bits));
    b = rec_t'(bits);
    check(b.tag == 4'hA && b.value == 8'h5C && b.mode == 3, "round trip lost information");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
