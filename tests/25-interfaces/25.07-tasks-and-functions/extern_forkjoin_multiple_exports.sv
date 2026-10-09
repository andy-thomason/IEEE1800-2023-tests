/*
:section: 25.7.4 Example of multiple task exports
:summary: An extern forkjoin task can be exported by several modules, with a call running all
  concurrently.
*/
interface multi_if;
  int hits;
  extern forkjoin task touch(input int id);
  modport target(export touch);
endinterface
module target_m #(parameter int ID = 0) (multi_if.target t);
  task t.touch(input int id);
    #1;
    if (id == ID) t.hits += 10; else t.hits += 1;
  endtask
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  multi_if bus();
  target_m #(1) t1(.t(bus));
  target_m #(2) t2(.t(bus));
  time done_at;
  initial begin
    #1;
    bus.touch(2);
    done_at = $time;
    check(bus.hits == 11, $sformatf("both exported tasks ran: hits=%0d", bus.hits));
    check(done_at == 2, "the call returned after both tasks (fork-join)");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
