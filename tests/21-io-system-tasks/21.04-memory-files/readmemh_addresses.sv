/*
:section: 21.4 Loading memory array data from a file
:summary: $readmemh loads from the lowest address by default, honours @address entries, and
  accepts explicit start and end limits.
:data: table.mem plain.mem
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [7:0] mem [0:7];
  logic [7:0] rev [0:3];
  initial begin
    foreach (mem[i]) mem[i] = 8'hEE;
    $readmemh("table.mem", mem);
    check(mem[0] == 8'h11 && mem[1] == 8'h22, "words loaded from the lowest address");
    check(mem[2] == 8'hEE, "a word skipped by an address specification was changed");
    check(mem[5] == 8'hAB && mem[6] == 8'hCD, "load after @5");
    $readmemh("plain.mem", rev, 3, 0);
    check(rev[3] == 8'h11 && rev[2] == 8'h22, "decrementing load");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
