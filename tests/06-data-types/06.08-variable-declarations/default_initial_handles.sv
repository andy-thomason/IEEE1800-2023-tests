/*
:section: 6.8 Variable declarations
:summary: Events start as new events, while class, chandle and virtual interface handles start
  as null.
*/
interface bus_if;
  logic ready;
endinterface

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class thing; endclass
  event ev;
  thing h;
  chandle ch;
  virtual bus_if vif;
  initial begin
    check(ev != null, "event default is a new event, not null");
    check(h == null, "class handle default is null");
    check(ch == null, "chandle default is null");
    check(vif == null, "virtual interface default is null");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
