/*
:section: 3.13 Name spaces
:summary: Attribute names live in their own name space, so they never collide with same-named
  variables.
:description: Attribute names do not clash with variables of the same name.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  (* tally *) int tally = 3;
  (* weight = 2 *) int weight = 7;
  initial begin
    check(tally == 3, $sformatf("tally = %0d", tally));
    check(weight == 7, $sformatf("weight = %0d", weight));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
