/*
:section: 13.8 Parameterized tasks and functions
:summary: Static methods of parameterized classes act as parameterized subroutines specialized
  per parameter value.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  virtual class coder #(parameter int W = 4);
    static function logic [2**W - 1:0] decode(logic [W - 1:0] v);
      return 1 << v;
    endfunction
    static function logic [W - 1:0] encode(logic [2**W - 1:0] v);
      for (int i = 0; i < 2**W; i++) if (v[i]) return i;
      return 0;
    endfunction
  endclass
  initial begin
    check(coder#(3)::decode(3'd5) == 8'b0010_0000, "decode with W = 3");
    check(coder#(4)::encode(16'h0400) == 4'd10, "encode with W = 4");
    check($bits(coder#(2)::decode(2'd1)) == 4, "result width follows the parameter");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
