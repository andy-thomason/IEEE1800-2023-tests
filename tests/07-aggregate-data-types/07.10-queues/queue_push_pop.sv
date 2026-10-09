/*
:section: 7.10.2.4 Pop_front()
:summary: Push methods add at either end; popping an empty queue returns the default value.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [7:0] q [$];
  string s [$];
  initial begin
    q.push_front(8'd2);
    q.push_front(8'd1);
    q.push_back(8'd3);
    check(q.pop_front() == 1 && q.pop_back() == 3 && q.size() == 1, "push and pop");
    void'(q.pop_back());
    check(q.pop_front() === 8'hxx && q.size() == 0, "pop_front on an empty 4-state queue");
    check(q.pop_back() === 8'hxx && q.size() == 0, "pop_back on an empty queue");
    check(s.pop_front() == "" && s.size() == 0, "pop_front on an empty string queue");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
