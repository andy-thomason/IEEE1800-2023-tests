/*
:section: 13.3.2 Task memory usage and concurrent activation
:summary: Static tasks share a single copy of their variables across concurrent calls, while
  automatic tasks get separate copies.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int s_out1, s_out2, a_out1, a_out2;
  task static_delay(input int v, output int r);
    #2 r = v;
  endtask
  task automatic auto_delay(input int v, output int r);
    #2 r = v;
  endtask
  task static_counter(output int n);
    int calls;
    calls++;
    n = calls;
  endtask
  initial begin
    fork
      static_delay(1, s_out1);
      #1 static_delay(2, s_out2);
      auto_delay(1, a_out1);
      #1 auto_delay(2, a_out2);
    join
    check(s_out1 == 2, $sformatf("static task: first call saw the second call's input (%0d)", s_out1));
    check(a_out1 == 1 && a_out2 == 2, "automatic task copies are separate");
    static_counter(s_out1);
    static_counter(s_out1);
    check(s_out1 == 2, "a static task variable kept its value between calls");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
