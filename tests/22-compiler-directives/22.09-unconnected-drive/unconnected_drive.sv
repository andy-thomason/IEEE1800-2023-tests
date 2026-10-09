/*
:section: 22.9 `unconnected_drive and `nounconnected_drive
:summary: `unconnected_drive pull1 makes unconnected inputs of modules before
  `nounconnected_drive read as logic 1.
*/
`unconnected_drive pull1
module pulled_up(input p, output o);
  assign o = p;
endmodule
`nounconnected_drive
module plain(input p, output o);
  assign o = p;
endmodule
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  wire up, normal;
  pulled_up u1(.p(), .o(up));
  plain u2(.p(), .o(normal));
  initial begin
    #1;
    check(up === 1'b1 && normal === 1'bz, $sformatf("pulled %b, normal %b", up, normal));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
