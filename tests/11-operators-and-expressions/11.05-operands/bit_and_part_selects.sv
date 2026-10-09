/*
:section: 11.5.1 Vector bit-select and part-select addressing
:summary: Bit- and part-selects follow the declared range direction, returning x or 0 for
  invalid addresses.
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
  logic [0:15] up = 16'hA5C3;
  bit [7:0] two_state = 8'hFF;
  logic [7:0] w = 8'h00;
  int idx;
  initial begin
    idx = 4;
    check(down[idx +: 4] == 4'hC && down[idx + 3 -: 4] == 4'hC, "indexed part-selects on a descending vector");
    check(up[idx +: 4] == 4'h5 && up[idx -: 4] == 4'h5 === 0, "indexed part-selects on an ascending vector");
    check(down[20] === 1'bx && two_state[9] === 1'b0, "out-of-range bit-select");
    check(down[17:14] === 4'bxx10, "partly out-of-range part-select");
    w[9:6] = 4'hF;
    check(w == 8'hC0, "write to a partly out-of-range part-select");
    w[12:10] = 3'b111;
    check(w == 8'hC0, "write to a completely out-of-range part-select");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
