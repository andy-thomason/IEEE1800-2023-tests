/*
:section: 6.23 Type operator
:summary: Inside a class, type(this) names the enclosing class type, including in static
  members.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class pool #(type T = int);
    static type(this) shared;
    static function type(this) get_shared();
      if (shared == null) shared = new();
      return shared;
    endfunction
  endclass
  class int_pool extends pool #();
    function type(this) self();
      return this;
    endfunction
  endclass
  pool #(byte) r1, r2;
  int_pool ir;
  initial begin
    r1 = pool#(byte)::get_shared();
    r2 = pool#(byte)::get_shared();
    ir = new;
    check(r1 != null && r1 == r2, "static type(this) singleton");
    check(ir.self() == ir, "type(this) in a derived class");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
