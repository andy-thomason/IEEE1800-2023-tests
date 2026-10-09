/*
:section: 6.16 String data type
:summary: Strings support equality, lexical relational comparison and concatenation, with
  literals converted to string type.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string a = "apple", b = "apricot", e = "";
  string joined;
  initial begin
    check(a == "apple" && a != b, "equality");
    check(a < b && b > a && a <= "apple" && b >= "apple", "lexicographic comparison");
    check("" < a, "empty string sorts first");
    joined = {a, "-", b};
    check(joined == "apple-apricot", $sformatf("concatenation gave %s", joined));
    joined = {e, "x", e};
    check(joined == "x" && joined.len() == 1, "empty string operands should add nothing");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
