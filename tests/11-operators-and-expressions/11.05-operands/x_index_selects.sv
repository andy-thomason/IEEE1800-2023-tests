/*
:section: 11.5.1 Vector bit-select and part-select addressing
:summary: An index containing x or z bits makes a bit-select, part-select or array read return
  x.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [15:0] down = 16'hA5C3;
  logic [7:0] mem [0:15];
  initial begin
    check(down[4'bx] === 1'bx, "x bit-select");
    check(down[4'b1z00 +: 2] === 2'bxx, "z part-select base");
    check(mem[4'bxx00] === 8'hxx, "x memory address");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
