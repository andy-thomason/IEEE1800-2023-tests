/*
:section: 7.9.8 Arguments to traversal methods
:summary: A traversal method with a too-small index argument truncates the key and returns -1.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string labels [int];
  byte small_index;
  int status;
  initial begin
    labels[300] = "x";
    status = labels.first(small_index);
    check(status == -1, $sformatf("status = %0d, expected -1", status));
    check(small_index == 8'sd44, $sformatf("index = %0d, expected 44 (300 truncated to 8 bits)", small_index));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
