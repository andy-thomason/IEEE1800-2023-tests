/*
:section: 19.4 Using covergroups in classes
:summary: A covergroup declared in a class can cover the class's local properties and is
  constructed in new.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function automatic bit near(real got, real want); return got > want - 0.01 && got < want + 0.01; endfunction
    class pkt_c;
      local bit [1:0] kind;
      covergroup cg;
        cp: coverpoint kind;
      endgroup
      function new(); cg = new; endfunction
      function void send(bit [1:0] k); kind = k; cg.sample(); endfunction
    endclass
    pkt_c p = new;
  initial begin
    p.send(0); p.send(1); p.send(1);
    check(near(p.cg.get_inst_coverage(), 50.0), $sformatf("embedded covergroup coverage %f", p.cg.get_inst_coverage()));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
