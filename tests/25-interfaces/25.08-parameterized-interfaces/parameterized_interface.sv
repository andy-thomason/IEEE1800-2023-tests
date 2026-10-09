/*
:section: 25.8 Parameterized interfaces
:summary: Interfaces accept value and type parameters and overrides in the same way as modules.
*/
interface fifo_if #(parameter int DEPTH = 2, parameter type T = logic [7:0]);
  T slots [DEPTH];
  function automatic int capacity(); return DEPTH * $bits(T); endfunction
endinterface
module user(fifo_if f, output int cap);
  assign cap = f.capacity();
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  fifo_if #(.DEPTH(4), .T(shortint)) wide();
  fifo_if narrow();
  int c1, c2;
  user u1(.f(wide), .cap(c1));
  user u2(.f(narrow), .cap(c2));
  initial begin
    #1;
    check(c1 == 64 && c2 == 16, $sformatf("capacities %0d %0d", c1, c2));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
