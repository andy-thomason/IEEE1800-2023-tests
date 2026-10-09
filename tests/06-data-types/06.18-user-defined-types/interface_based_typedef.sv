/*
:section: 6.18 User-defined types
:summary: A module may redeclare a typedef reached through an interface port and then use it.
*/
interface link_if;
  typedef logic [10:0] word_t;
  word_t data;
endinterface

module user(link_if port);
  typedef port.word_t local_word_t;
  local_word_t copy;
  initial copy = 11'h5AA;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  link_if bus();
  user u(.port(bus));
  initial begin
    #1;
    check($bits(u.copy) == 11 && u.copy == 11'h5AA, "type from an interface port");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
