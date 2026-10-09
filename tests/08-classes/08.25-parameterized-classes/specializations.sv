/*
:section: 8.25 Parameterized classes
:summary: Specializations with equal parameters are one type, and each distinct specialization
  has its own static members.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class stack_c #(type T = int, int DEPTH = 4);
    static int created = 0;
    T items [$];
    function new(); created++; endfunction
    function void push(T v); if (items.size() < DEPTH) items.push_back(v); endfunction
  endclass
  typedef stack_c #(byte, 2) small_stack_t;
  stack_c a1, a2;
  stack_c #(int, 4) a3;
  small_stack_t b1;
  stack_c #(.DEPTH(2), .T(byte)) b2;
  initial begin
    a1 = new; a2 = new; a3 = new;
    b1 = new;
    b2 = b1;
    check(stack_c#()::created == 3, "default and explicit-default specializations do not share statics");
    check(small_stack_t::created == 1, "separate statics per specialization");
    b1.push(1); b1.push(2); b1.push(3);
    check(b2.items.size() == 2, "DEPTH parameter / matching specialization");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
