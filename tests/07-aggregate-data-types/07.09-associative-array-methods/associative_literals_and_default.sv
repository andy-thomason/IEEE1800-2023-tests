/*
:section: 7.9.11 Associative array literals
:summary: Associative array literals use index:value pairs, and a default answers reads of
  missing keys.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  integer ages [string] = '{"ann": 31, "bo": 27, default: -1};
  string greet [int] = '{default: "hi"};
  initial begin
    check(ages["bo"] == 27 && ages["cy"] == -1, "literal values and default");
    check(ages.num() == 2 && !ages.exists("cy"), "the default changed the methods");
    check(greet[123] == "hi" && greet.num() == 0, "default only");
    ages = '{"dee": 40};
    check(ages.num() == 1 && ages["dee"] == 40 && !ages.exists("ann"), "replacing the contents with a literal");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
