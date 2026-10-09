/*
:section: 25.10 Access to interface objects
:summary: Hierarchical access through an interface port still reaches types and parameters not
  listed in a modport.
*/
interface mode_if;
  typedef enum {IDLE, BUSY} state_t;
  parameter int DEPTH = 4;
  state_t state;
  int hidden;
  modport mp(output state);
endinterface
module user(mode_if.mp p, output int depth);
  typedef p.state_t st;
  initial p.state = st'(1);
  assign depth = p.DEPTH;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  mode_if m();
  int depth;
  user u(.p(m), .depth(depth));
  initial m.hidden = 9;
  initial begin
    #1;
    check(m.state == m.BUSY, "type from the interface used through the modport port");
    check(depth == 4, "parameter read through the modport port");
    check(top.m.hidden == 9, "hierarchical reference to an item outside the modport");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
