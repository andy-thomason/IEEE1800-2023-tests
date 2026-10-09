/*
:section: 18.5.9 Variable ordering
:summary: solve before alters value probabilities but does not change which solutions are legal.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class order_c;
    rand bit [15:0] payload;
    rand bit is_empty;
    constraint order { is_empty -> payload == 16'h0; solve is_empty before payload; }
  endclass
  order_c o = new;
  int ones = 0, bad = 0;
  initial begin
    repeat (200) begin
      void'(o.randomize());
      if (o.is_empty) begin ones++; if (o.payload != 0) bad++; end
    end
    check(bad == 0, "solve before changed the solution space");
    check(ones > 20, $sformatf("with is_empty solved first, it was 1 only %0d times out of 200", ones));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
