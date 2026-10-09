/*
:section: 6.22.2 Equivalent types
:summary: Variables declared together with one anonymous unpacked struct type are equivalent and
  assignable.
*/
module top;
  struct { int a; byte b; } p, q;
  initial begin
    q.a = 5; q.b = 6;
    p = q;
    if (p.a != 5 || p.b != 6) $display("FAIL: assignment between equivalent anonymous structs");
    else $display("PASS");
    $finish;
  end
endmodule
