/*
:section: 8.4 Objects (class instance)
:summary: A class handle that has not been constructed holds null and compares equal to null.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class thing; endclass
  thing t;
  initial begin
    check(t == null, "an uninitialised handle is not null");
    t = new;
    check(t != null, "a constructed handle is null");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
