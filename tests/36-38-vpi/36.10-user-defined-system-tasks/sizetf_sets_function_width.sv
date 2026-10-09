/*
:section: 36.10.2 sizetf VPI application routine
:summary: sizetf determines a user system function's result width, which defaults to 32 bits
  otherwise.
:vpi: sizetf_sets_function_width.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [63:0] wide, plain;
  initial begin
    wide = $t_ones48();
    plain = $t_ones32();
    check(wide == 64'h0000_FFFF_FFFF_FFFF, $sformatf("48-bit system function gave %h", wide));
    check(plain == 64'h0000_0000_FFFF_FFFF, $sformatf("default 32-bit system function gave %h", plain));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
