/*
:section: 6.8 Variable declarations
:summary: Static variable initializers, including runtime calls and new, finish before initial
  or always procedures begin.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class box; int v = 3; endclass
  int seed = 41;
  int from_call = $urandom_range(7, 7);
  box handle = new;
  int seen_initial = -1, seen_always = -1;
  initial seen_initial = seed;
  always @(seed) ;
  always_comb seen_always = seed + 0;
  initial begin
    #0;
    check(seen_initial == 41, $sformatf("initial procedure saw %0d", seen_initial));
    check(seen_always == 41, $sformatf("always_comb saw %0d", seen_always));
    check(from_call == 7, "initialiser with a function call");
    check(handle != null && handle.v == 3, "initialiser with new");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
