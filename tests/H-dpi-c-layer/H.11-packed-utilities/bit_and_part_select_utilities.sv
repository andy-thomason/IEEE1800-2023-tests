/*
:section: H.11.5 Utility functions for working with the canonical representation
:summary: DPI utilities set and get bit and part selects of canonical packed vectors without
  disturbing other bits.
:dpi: bit_and_part_select_utilities.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function void edit(inout bit [47:0] v, output int got, output int sel);
  import "DPI-C" function void edit4(inout logic [7:0] v);
  bit [47:0] v = 48'h0000_FFFF_0000;
  logic [7:0] l = 8'b0000_0000;
  int got, sel;
  initial begin
    edit(v, got, sel);
    check(got == 1, "svGetBitselBit read bit 16");
    check(sel == 32'hDEAD_00FF, $sformatf("svGetPartselBit kept bits [31:8] of the destination: %h", sel));
    check(v == 48'h0005_FFFF_0001, $sformatf("svPutPartselBit / svPutBitselBit gave %h", v));
    edit4(l);
    check(l === 8'b00z0_000x, $sformatf("svPutBitselLogic gave %b", l));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
