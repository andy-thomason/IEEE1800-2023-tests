/*
:section: 25.3.2 Interface example using a named bundle
:summary: An interface can bundle nets and variables and be passed through module ports as one
  connection.
*/
interface pair_if;
  logic [7:0] value;
  logic valid;
endinterface
module sender(pair_if p);
  initial begin
    p.value = 8'h3C;
    p.valid = 1;
  end
endmodule
module receiver(pair_if p, output logic [7:0] got);
  assign got = p.valid ? p.value : 8'h00;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  pair_if link();
  logic [7:0] got;
  sender s(.p(link));
  receiver r(.p(link), .got(got));
  initial begin
    #1;
    check(got == 8'h3C, $sformatf("value through the interface = %h", got));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
