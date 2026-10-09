/*
:section: 6.13 Void data type
:summary: A function may have a void return type, meaning it yields no value.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int total = 0;
  function void add(int v);
    total += v;
  endfunction
  initial begin
    add(4);
    add(5);
    check(total == 9, "void function side effects");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
