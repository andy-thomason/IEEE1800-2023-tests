/*
:section: 6.7.3 Initialization of nets with user-defined nettypes
:summary: User-defined nettype nets start at their type's default, including struct member
  initializers, with resolution run at time zero.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct { int level = 5; real gain = 1.5; } sig_t;
  nettype sig_t sig_net;
  nettype logic [3:0] nibble_net;
  int calls = 0;
  function automatic int count_resolve(input int drivers []);
    calls++;
    return drivers.size();
  endfunction
  nettype int counted_net with count_resolve;
  sig_net s;
  nibble_net n;
  counted_net c;
  initial begin
    #1;
    check(s.level == 5 && s.gain == 1.5, "struct member initialisers were not applied");
    check(n === 4'bxxxx, $sformatf("undriven logic user-defined net = %b, expected x (not z)", n));
    check(calls >= 1, "resolution function was not called at time zero");
    check(c == 0, $sformatf("resolution of no drivers = %0d", c));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
