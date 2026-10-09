/*
:section: 9.2.2.2 Combinational logic always_comb procedure
:summary: always_comb runs once at time zero and is sensitive to everything it reads, including
  called functions.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] a = 4'd3, b = 4'd4;
  logic [3:0] sum_comb, sum_star, via_fn;
  int star_runs = 0;
  function automatic void count_star(); star_runs++; endfunction
  function automatic logic [3:0] add_b(logic [3:0] x); return x + b; endfunction
  always_comb sum_comb = a + b;
  always @* begin sum_star = a + b; count_star(); end
  always_comb via_fn = add_b(a);
  initial begin
    #0;
    check(sum_comb == 7, "always_comb did not run at time zero");
    check(star_runs == 0, "always @* ran at time zero without a change");
    b = 4'd5;
    #1;
    check(via_fn == 8, "always_comb is not sensitive to variables read inside a called function");
    check(sum_comb == 8 && sum_star == 8, "both procedures follow a change");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
