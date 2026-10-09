/*
:section: 21.2.1.4 Strength format
:summary: %v prints a scalar net's strength and value in three characters, and %m prints the
  hierarchical scope name.
:expect: St1 Pu0 HiZ
  top.named
  in top.u_leaf.show
*/
module leaf;
  task show(); $display("in %m"); endtask
endmodule
module top;
  wire st = 1'b1;
  wire (pull0, pull1) pu = 1'b0;
  wire hz;
  leaf u_leaf();
  initial begin
    #1;
    $display("%v %v %v", st, pu, hz);
    begin : named
      $display("%m");
    end
    u_leaf.show();
    $finish;
  end
endmodule
