/*
:section: 8.24 Out-of-block declarations
:summary: Extern methods declared in a class can be defined outside it using the class::method
  form with a matching prototype.
*/
class calc_c;
  typedef logic [7:0] byte_t;
  int base = 10;
  extern function byte_t scaled(int k);
  extern static function int twice(int v);
  extern task bump(input int n);
endclass

function calc_c::byte_t calc_c::scaled(int k);
  return base * k;
endfunction
function int calc_c::twice(int v);
  return 2 * v;
endfunction
task calc_c::bump(input int n);
  base += n;
endtask

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  calc_c c = new;
  initial begin
    check(c.scaled(3) == 30 && calc_c::twice(4) == 8, "out-of-block functions");
    c.bump(5);
    check(c.base == 15, "out-of-block task");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
