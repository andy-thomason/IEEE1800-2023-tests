/*
:section: 6.19.5 Enumerated type methods
:summary: For non-member values, next and prev return the default value and name returns an
  empty string.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef enum {ONE = 1, TWO, THREE} n_t;
  n_t v;
  initial begin
    v = n_t'(7);
    check(int'(v.next()) == 0, $sformatf("next of a non-member = %0d, expected 0 (int default)", v.next()));
    check(int'(v.prev()) == 0, $sformatf("prev of a non-member = %0d, expected 0", v.prev()));
    check(v.name() == "", $sformatf("name of a non-member = '%s'", v.name()));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
