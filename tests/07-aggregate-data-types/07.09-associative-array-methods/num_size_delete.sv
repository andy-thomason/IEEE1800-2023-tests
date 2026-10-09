/*
:section: 7.9.1 Num() and size()
:summary: num() and size() count entries, and delete() removes one entry or all entries.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int table_of [int];
  initial begin
    check(table_of.num() == 0 && table_of.size() == 0, "empty array");
    table_of[4] = 1;
    table_of[16'hFFFF] = 2;
    table_of[3'b100] = 3;
    check(table_of.num() == 2 && table_of.size() == 2, $sformatf("num = %0d", table_of.num()));
    table_of.delete(65535);
    table_of.delete(12345);
    check(table_of.num() == 1 && table_of[4] == 3, "delete by index");
    table_of.delete();
    check(table_of.num() == 0, "delete all");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
