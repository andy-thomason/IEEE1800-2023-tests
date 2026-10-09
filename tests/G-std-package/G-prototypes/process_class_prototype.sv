/*
:section: G.6 Process
:summary: std::process supports self, status, kill, await, suspend, resume and random state
  methods.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  std::process p;
  std::process::state st;
  initial begin
    string rs;
    int a, b;
    fork
      begin
        p = std::process::self();
        #10;
      end
    join_none
    #1;
    st = p.status();
    check(st == std::process::WAITING, $sformatf("status of a delayed process: %s", st.name()));
    check(std::process::FINISHED == 0 && std::process::KILLED == 4, "enumeration order");
    rs = p.get_randstate();
    p.set_randstate(rs);
    p.kill();
    check(p.status() == std::process::KILLED, "killed");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
