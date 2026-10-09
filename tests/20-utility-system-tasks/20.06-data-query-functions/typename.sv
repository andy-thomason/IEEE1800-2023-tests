/*
:section: 20.6.1 Type name function
:summary: $typename returns the resolved type name, expanding typedefs and dropping default
  signing.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef int my_int_t;
  int signed a;
  my_int_t b;
  string s;
  real r;
  initial begin
    check($typename(a) == "int", $sformatf("$typename(int signed) = %s", $typename(a)));
    check($typename(b) == "int", $sformatf("a typedef was not resolved: %s", $typename(b)));
    check($typename(s) == "string" && $typename(r) == "real", "string and real");
    check($typename(a) == $typename(b), "matching types give equal names");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
