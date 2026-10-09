/*
:section: 8.12 Assignment, renaming, and copying
:summary: Shallow copying through a base handle duplicates the full derived object, including
  its extended properties.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class base_c; int b = 1; virtual function string kind(); return "base"; endfunction endclass
  class ext_c extends base_c; int e = 2; virtual function string kind(); return "ext"; endfunction endclass
  base_c h1, h2;
  ext_c x;
  initial begin
    x = new;
    x.e = 20;
    h1 = x;
    h2 = new h1;
    check(h2.kind() == "ext", "shallow copy through a base handle did not copy the derived object");
    check($cast(x, h2) && x.e == 20, "derived property was not copied");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
