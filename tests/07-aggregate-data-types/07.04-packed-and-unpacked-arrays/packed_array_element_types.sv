/*
:section: 7.4.1 Packed arrays
:summary: Packed arrays may use enums, packed structs and reg as elements; predefined integers
  can be bit-selected.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef enum bit [1:0] {A, B, C} abc_t;
  typedef struct packed { bit flag; bit [2:0] val; } item_t;
  abc_t [2:0] enums;
  item_t [1:0] items;
  reg [3:0][1:0] regs;
  byte b = -2;
  integer i = 32'h1234_5678;
  initial begin
    enums[1] = C;
    check(enums[1] == C && $bits(enums) == 6, "packed array of enums");
    items = 8'b1_011_0_101;
    check(items[1].val == 3 && items[0].flag == 0, "packed array of packed structs");
    regs = 8'hA5;
    check(regs[3] == 2'b10, "packed array of reg");
    check(b[7] == 1'b1 && b[3:0] == 4'hE, "select from byte");
    check(i[31:16] == 16'h1234, "part-select from integer");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
