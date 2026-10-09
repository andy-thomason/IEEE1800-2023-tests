/*
:section: 7.3.1 Packed unions
:summary: Packed untagged unions let data written via one member be read through another member.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct packed { bit [7:0] hi; bit [7:0] lo; } halves_t;
  union packed { bit [15:0] word; halves_t halves; bit [1:0][7:0] bytes; } u;
  union packed signed { bit [7:0] raw; bit [1:0][3:0] nibbles; } s;
  initial begin
    u.word = 16'hBEEF;
    check(u.halves.hi == 8'hBE && u.halves.lo == 8'hEF, "struct view of a word");
    check(u.bytes[1] == 8'hBE, "array view of a word");
    check(u[3:0] == 4'hF && u + 1 == 16'hBEF0, "union used as a vector");
    s.raw = 8'h80;
    check(s < 0, "signed packed union is not signed");
    check(s.nibbles[1] == 4'h8, "nibble view");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
