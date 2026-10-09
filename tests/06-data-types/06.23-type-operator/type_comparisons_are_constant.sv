/*
:section: 6.23 Type operator
:summary: Comparisons between type references are constant and true exactly when the types
  match.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [12:0] bus;
  parameter type bus_t = type(bus);
  localparam int KIND = (type(bus_t) == type(logic [12:0])) ? 1 : 2;
  int chosen;
  case (type(bus_t))
    type(real): begin : as_real  initial chosen = 10; end
    type(logic [12:0]): begin : as_logic  initial chosen = 20; end
  endcase
  initial begin
    #1;
    check(KIND == 1, "type comparison in a parameter expression");
    check(chosen == 20, "generate case on a type");
    check(type(bus) === type(logic [12:0]) && type(bus) !== type(bit [12:0]), "case equality of types");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
