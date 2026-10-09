/*
:section: 20.9 Bit vector system functions
:summary: Bit vector functions accept any bit-stream argument, such as unpacked arrays and
  structs, by streaming it into a vector.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  bit [3:0] arr [2] = '{4'b0001, 4'b0011};
  typedef struct { logic [1:0] a; bit b; } st_t;
  st_t s;
  initial begin
    check($countones(arr) == 3, "unpacked array argument");
    s.a = 2'b1x; s.b = 1;
    check($countbits(s, '1) == 2 && $isunknown(s), "unpacked struct argument");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
