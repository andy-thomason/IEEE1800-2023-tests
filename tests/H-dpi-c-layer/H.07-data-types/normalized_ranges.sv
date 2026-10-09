/*
:section: H.7.6 Mapping between SystemVerilog ranges and C ranges
:summary: DPI normalizes packed ranges so the LSB is index 0, and unpacked arrays keep natural
  index order.
:dpi: normalized_ranges.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function int low_bit(input bit [7:4] v);
  import "DPI-C" function int first_elem(input int a [5:2]);
  int arr [5:2];
  initial begin
    arr[2] = 22; arr[5] = 55;
    check(low_bit(4'b0001) == 1 && low_bit(4'b1000) == 0, "v[4] is normalized bit 0");
    check(first_elem(arr) == 22, "element min(L,R)=2 is C index 0");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
