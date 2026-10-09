/*
:section: 11.5.2 Array and memory addressing
:summary: Memory and multidimensional array elements are addressed by index, with out-of-range
  reads returning the default value.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [7:0] mem [0:15];
  logic [7:0] twod [0:3][1:2];
  initial begin
    foreach (mem[i]) mem[i] = i;
    mem[3] = 8'd9;
    check(mem[mem[3]] == 9, "a memory word used as an address");
    twod[2][1] = 8'hA5;
    check(twod[2][1][3:0] == 4'h5 && twod[2][1][7] == 1'b1, "select within an element of a 2-D array");
    check(mem[16] === 8'hxx, "out-of-range address");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
