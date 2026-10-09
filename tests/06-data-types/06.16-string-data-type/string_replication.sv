/*
:section: 6.16 String data type
:summary: String replication accepts a non-constant count, and a zero count produces an empty
  string.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string unit = "ab";
  string r;
  int n = 3;
  initial begin
    r = {n{unit}};
    check(r == "ababab", $sformatf("{3{unit}} = %s", r));
    r = {n{"xy"}};
    check(r == "xyxyxy", $sformatf("non-constant replication of a literal = %s", r));
    n = 0;
    r = {n{unit}};
    check(r == "" && r.len() == 0, "zero replication is not the empty string");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
