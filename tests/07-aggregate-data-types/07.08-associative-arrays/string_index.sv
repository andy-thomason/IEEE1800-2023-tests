/*
:section: 7.8.2 String index
:summary: String-indexed associative arrays accept empty and long keys and iterate in
  lexicographic order.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int by_name [string];
  string key;
  string order;
  initial begin
    by_name["pear"] = 1;
    by_name[""] = 2;
    by_name["apple"] = 3;
    key = "a_rather_long_key_of_more_than_thirty_two_characters";
    by_name[key] = 4;
    check(by_name[""] == 2 && by_name[key] == 4, "empty and long string indices");
    order = "";
    if (by_name.first(key)) do order = {order, "|", key}; while (by_name.next(key));
    check(order == "||a_rather_long_key_of_more_than_thirty_two_characters|apple|pear", $sformatf("order: %s", order));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
