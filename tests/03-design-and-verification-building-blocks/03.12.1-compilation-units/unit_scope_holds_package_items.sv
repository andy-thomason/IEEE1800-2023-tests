/*
:section: 3.12.1 Compilation units
:summary: The compilation-unit scope may hold package-style items such as typedefs, parameters,
  constants, variables and subroutines.
*/
typedef enum logic [1:0] { IDLE, BUSY, DONE } phase_t;
typedef struct packed { phase_t phase; logic [5:0] count; } status_t;
localparam int WINDOW = 16;
parameter int SCALE = 3;
const int BASE = 100;
int unit_counter = 0;

function automatic int scaled(int v);
  return v * SCALE;
endfunction

task automatic tick(inout int c);
  c++;
endtask

class accumulator;
  int total;
  function void add(int v);
    total += v;
  endfunction
endclass

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  status_t s;
  accumulator acc;
  initial begin
    s.phase = BUSY;
    s.count = 6'd9;
    check(s.phase == BUSY && s.count == 9, "struct of enum from compilation-unit scope");
    check(WINDOW == 16 && SCALE == 3 && BASE == 100, "parameters and constants");
    check(scaled(7) == 21, $sformatf("scaled(7) = %0d", scaled(7)));
    tick(unit_counter);
    tick(unit_counter);
    check(unit_counter == 2, $sformatf("unit_counter = %0d", unit_counter));
    acc = new();
    acc.add(4);
    acc.add(5);
    check(acc.total == 9, $sformatf("class method total = %0d", acc.total));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
