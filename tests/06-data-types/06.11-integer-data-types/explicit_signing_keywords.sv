/*
:section: 6.11.3 Signed and unsigned integer types
:summary: The signed and unsigned keywords override the default signedness of integer types.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int unsigned ui = '1;
  byte unsigned ub = '1;
  longint unsigned ul = '1;
  logic signed [3:0] ls = '1;
  bit signed [5:0] bs = '1;
  bit [3:0] arr [2];
  initial begin
    arr[0] = '1;
    check(ui > 0 && ub > 0 && ul > 0, "unsigned integer types are not unsigned");
    check(ls < 0 && bs < 0, "signed vectors are not signed");
    check(arr[0] > 0, "an array element of bit is not unsigned");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
