/*
:section: 6.8 Variable declarations
:summary: Variables start at x for 4-state, 0 for 2-state, 0.0 for real and empty for strings.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef enum logic [1:0] {A = 1, B = 2} four_state_enum_t;
  typedef enum bit [1:0] {C = 1, D = 2} two_state_enum_t;
  logic [7:0] l; integer ig; bit [7:0] b; int i;
  real r; shortreal sr;
  four_state_enum_t e4; two_state_enum_t e2;
  string s;
  initial begin
    check(l === 8'hxx && ig === 32'hxxxx_xxxx, "4-state integral default is x");
    check(b === 8'h00 && i === 0, "2-state integral default is 0");
    check(r == 0.0 && sr == 0.0, "real default is 0.0");
    check(e4 === 2'bxx && e2 === 2'b00, "enum default is the base type default");
    check(s == "", "string default is empty");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
