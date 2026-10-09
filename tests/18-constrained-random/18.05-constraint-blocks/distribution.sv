/*
:section: 18.5.3 Distribution
:summary: In dist, := gives each value the weight, :/ spreads the weight over a range, and zero
  weight excludes values.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class dist_c;
    rand bit [3:0] v;
    constraint c { v dist { 0 := 5, [1:3] :/ 5, 4 := 0, [5:15] := 0 }; }
  endclass
  dist_c d = new;
  int counts [16];
  initial begin
    repeat (400) begin
      void'(d.randomize());
      counts[d.v]++;
    end
    check(counts[4] == 0 && counts[15] == 0, "a value with weight zero was chosen");
    check(counts[0] > 0 && counts[1] + counts[2] + counts[3] > 0, "values with weight were never chosen");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
