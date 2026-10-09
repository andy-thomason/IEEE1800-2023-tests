/*
:section: 25.5.5 Clocking blocks and modports
:summary: A clocking block listed in a modport must be declared in the same interface.
:type: elaboration
:should_fail_because: the modport names a clocking block declared outside the interface
*/
module top;
  logic clk;
  clocking other @(posedge clk); endclocking
  interface sync_if;
    modport drv(clocking other);
  endinterface
  sync_if s();
endmodule
