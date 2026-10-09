/*
:section: 18.13.4 get_randstate()
:summary: srandom() seeds an object's generator, and get_randstate() with set_randstate() saves
  and restores its state.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class gen_c; rand int v; endclass
  gen_c g = new;
  string state;
  int first [3], again [3];
  initial begin
    g.srandom(123);
    state = g.get_randstate();
    for (int i = 0; i < 3; i++) begin void'(g.randomize()); first[i] = g.v; end
    g.set_randstate(state);
    for (int i = 0; i < 3; i++) begin void'(g.randomize()); again[i] = g.v; end
    check(first == again, "restoring the RNG state did not repeat the values");
    g.srandom(123);
    void'(g.randomize());
    check(g.v == first[0], "srandom with the same seed did not repeat the first value");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
