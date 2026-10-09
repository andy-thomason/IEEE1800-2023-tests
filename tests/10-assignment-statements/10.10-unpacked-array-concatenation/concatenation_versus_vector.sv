/*
:section: 10.10.3 Nesting of unpacked array concatenations
:summary: Braces with packed operands form a vector concatenation, but assigned to an unpacked
  array they build elements.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [7:0] vec;
  logic [7:0] arr [2];
  int jagged [$][$];
  initial begin
    vec = {4'h3, 4'hc};
    arr = {4'h3, 4'hc};
    check(vec == 8'h3c, "vector concatenation");
    check(arr[0] == 8'h03 && arr[1] == 8'h0c, "array concatenation of the same items");
    jagged = {{1}, {2, 3, 4}, {5, 6}};
    check(jagged.size() == 3 && jagged[1].size() == 3 && jagged[2][1] == 6, "nested concatenations build a jagged queue");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
