/*
:section: 25.7 Tasks and functions in interfaces
:summary: When defaults appear in both prototype and definition, the modport prototype default
  value applies.
*/
interface calc_if;
  function automatic int add(input int a, input int b = 100);
    return a + b;
  endfunction
  modport user(import function int add(input int a, input int b = 3));
endinterface
module m(calc_if.user c, output int r);
  initial r = c.add(1);
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  calc_if ci();
  int r;
  m u(.c(ci), .r(r));
  initial begin
    #1;
    check(r == 4, $sformatf("default from the prototype expected 4, got %0d", r));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
