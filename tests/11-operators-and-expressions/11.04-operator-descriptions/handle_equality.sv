/*
:section: 11.4.5 Equality operators
:summary: Class handles and chandles may be compared with == and != against each other or
  against null.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class c_t; endclass
  c_t h1 = new, h2;
  chandle ch;
  initial begin
    h2 = h1;
    check(h1 == h2 && h1 === h2 && h1 != null, "class handle equality");
    check(ch == null && ch === null, "chandle equality with null");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
