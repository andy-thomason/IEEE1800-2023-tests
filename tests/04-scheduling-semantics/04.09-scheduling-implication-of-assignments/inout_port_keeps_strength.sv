/*
:section: 4.9.6 Port connections
:summary: An inout port connection passes signal strength through unchanged, unlike a resistive
  switch.
:description: If the port reduced the inside pull strength, the outside pull0 driver would win and
  the line would be 0.
*/
module pulls_up(inout wire io);
  assign (pull0, pull1) io = 1'b1;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  wire line;
  assign (pull0, pull1) line = 1'b0;
  pulls_up u(.io(line));
  initial begin
    #1 check(line === 1'bx, $sformatf("line = %b; two pull drivers of opposite value should give x", line));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
