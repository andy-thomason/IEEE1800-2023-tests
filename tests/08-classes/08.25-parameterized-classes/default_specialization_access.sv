/*
:section: 8.25.1 Class scope resolution operator for parameterized classes
:summary: C#()::p and a typedef of C both name the default specialization of a parameterized
  class.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class holder_c #(int p = 1);
    static function int twice(); return 2 * p; endfunction
  endclass
  typedef holder_c default_t;
  initial begin
    check(holder_c#()::p == 1 && default_t::p == 1, "default specialization through #() and a typedef");
    check(holder_c#(5)::twice() == 10 && holder_c#()::twice() == 2, "static method per specialization");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
