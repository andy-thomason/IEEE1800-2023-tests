/*
:section: 7.4.5 Indexing and slicing of arrays
:summary: An index with x or z bits returns the default on read and is ignored on write.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int i2 [4] = '{5, 5, 5, 5};
  logic [3:0] l4 [4] = '{4'd5, 4'd5, 4'd5, 4'd5};
  initial begin
    check(i2['x] === 0, "read with an x index from a 2-state array");
    check(l4[2'b1z] === 4'bxxxx, "read with a z index from a 4-state array");
    i2['x] = 99;
    check(i2[0] == 5 && i2[1] == 5 && i2[2] == 5 && i2[3] == 5, "a write with an x index changed the array");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
