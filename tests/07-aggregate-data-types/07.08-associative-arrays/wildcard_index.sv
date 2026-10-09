/*
:section: 7.8.1 Wildcard index type
:summary: Wildcard indices ignore leading zeros, so equal numeric values of differing width
  share one entry.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int any_key [*];
  initial begin
    any_key[8'd5] = 1;
    any_key[32'd5] = 2;
    any_key[3'b101] = 3;
    check(any_key.num() == 1 && any_key[5] == 3, "different-width forms of 5 are not one entry");
    any_key[-1] = 4;
    check(any_key.exists(32'hFFFF_FFFF) && !any_key.exists(-64'sd1), "index not treated as unsigned and self-determined");
    any_key["AB"] = 6;
    check(any_key[16'h4142] == 6, "string literal index is not a bit vector");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
