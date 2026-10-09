/*
:section: 23.3.3.7 Port connections with dissimilar net types (net and port collapsing)
:summary: Connecting a wire to a wand port collapses both into the dominant net type per the net
  collapsing rules.
:description: Table 23-1: wand dominates wire, so the collapsed net resolves as wand.
*/
module drives_wand(inout wand w);
  assign w = 1'b0;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  wire shared;
  assign shared = 1'b1;
  drives_wand u(.w(shared));
  initial begin
    #1;
    check(shared === 1'b0, $sformatf("external wire collapsed with internal wand gave %b, expected wired-and 0", shared));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
