/*
:section: 6.16 String data type
:summary: Reading a string at an out-of-range index, including any index of an empty string,
  yields 0.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string s = "ab";
  string e;
  byte c;
  initial begin
    c = s[2];  check(c == 0, $sformatf("s[2] = %0d", c));
    c = s[-1]; check(c == 0, $sformatf("s[-1] = %0d", c));
    c = e[0];  check(c == 0, $sformatf("empty string [0] = %0d", c));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
