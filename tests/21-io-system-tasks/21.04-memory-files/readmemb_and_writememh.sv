/*
:section: 21.5 Writing memory array data to a file
:summary: $readmemb loads binary data including x and z digits, and $writememh output can be
  read back with $readmemh.
:data: bits.mem
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] src [0:3];
  logic [3:0] copy [0:3];
  initial begin
    $readmemb("bits.mem", src);
    check(src[0] == 4'b1010 && src[3] === 4'bx01z, "$readmemb with x and z digits");
    $writememh("dump.mem", src);
    $readmemh("dump.mem", copy);
    check(copy[0] == src[0] && copy[1] == src[1] && copy[2] == src[2], "$writememh output read back with $readmemh");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
