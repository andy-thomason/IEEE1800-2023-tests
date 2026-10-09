/*
:section: 18.5.4 Uniqueness constraints
:summary: A unique constraint forces every listed variable or array element to receive a
  distinct value.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class trio_c;
    rand bit [2:0] a, b, c;
    rand bit [2:0] arr [4];
    constraint u { unique {a, b, c}; unique {arr}; }
  endclass
  trio_c t = new;
  int bad = 0;
  initial begin
    repeat (100) begin
      void'(t.randomize());
      if (t.a == t.b || t.b == t.c || t.a == t.c) bad++;
      foreach (t.arr[i]) foreach (t.arr[j]) if (i < j && t.arr[i] == t.arr[j]) bad++;
    end
    check(bad == 0, "unique produced duplicates");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
