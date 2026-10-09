/*
:section: 38.24 vpi_iterate()
:summary: vpi_iterate walks one-to-many relations like child modules and returns NULL when none
  exist.
:vpi: iterate_module_contents.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  sub a(), b(), c();
  int modules, tops_ok, none_ok;
  initial begin
    $t_walk(modules, tops_ok, none_ok);
    check(modules == 3, $sformatf("vpiModule iteration in top found %0d instances", modules));
    check(tops_ok == 1, "top is found among the top-level modules");
    check(none_ok == 1, "iterating an empty relationship returns NULL");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule

module sub;
endmodule
