/*
:section: 18.17 Random sequence generation—randsequence
:summary: randsequence productions support weights, if-else, case, repeat, break, return, and
  passing values between productions.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string trace;
  int depth = 2;
  initial begin
    trace = "";
    randsequence (main)
      main : first second third;
      first : { trace = {trace, "f"}; };
      second : if (depth > 1) deep else shallow;
      deep : { trace = {trace, "d"}; };
      shallow : { trace = {trace, "s"}; };
      third : repeat (3) dot;
      dot : { trace = {trace, "."}; };
    endsequence
    check(trace == "fd...", $sformatf("production trace %s", trace));
    trace = "";
    randsequence (top_p)
      top_p : pick := 1 | never := 0;
      pick : case (depth) 2: two; default: other; endcase;
      two : { trace = {trace, "2"}; } stop more;
      stop : { return; };
      more : { trace = {trace, "!"}; };
      never : { trace = {trace, "x"}; };
      other : { trace = {trace, "o"}; };
    endsequence
    check(trace == "2!", $sformatf("weights, case and return: %s", trace));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
