/*
:section: 8.27 Typedef class
:summary: A typedef class forward declaration lets two classes refer to each other before both
  are defined.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef class second_c;
  class first_c;
    second_c partner;
  endclass
  class second_c;
    first_c partner;
    int id = 2;
  endclass
  first_c f;
  initial begin
    f = new;
    f.partner = new;
    f.partner.partner = f;
    check(f.partner.id == 2 && f.partner.partner == f, "mutually referential classes");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
