/*
:section: 7.5.1 New[ ]
:summary: new[] with an initializer array copies elements, truncating or padding with defaults
  as needed.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int source [4] = '{7, 8, 9, 10};
  int shorter [], longer [], grow [];
  initial begin
    shorter = new [2] (source);
    check(shorter.size() == 2 && shorter[1] == 8, "truncating initialiser");
    longer = new [6] (source);
    check(longer.size() == 6 && longer[3] == 10 && longer[5] == 0, "padding initialiser");
    grow = new [2];
    grow[0] = 11; grow[1] = 12;
    grow = new [grow.size() * 3] (grow);
    check(grow.size() == 6 && grow[1] == 12 && grow[5] == 0, "resize preserving contents");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
