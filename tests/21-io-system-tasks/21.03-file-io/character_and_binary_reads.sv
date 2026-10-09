/*
:section: 21.3.4.4 Reading binary data
:summary: $fgetc, $ungetc and $fread read characters or binary data from files, returning EOF or
  counts as appropriate.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int fd, c, n, pos;
  logic [15:0] word;
  logic [7:0] mem [0:3];
  initial begin
    fd = $fopen("bin_test.dat", "wb");
    $fwrite(fd, "%c%c%c%c%c%c", 8'h41, 8'h42, 8'h43, 8'h44, 8'h45, 8'h46);
    $fclose(fd);
    fd = $fopen("bin_test.dat", "rb");
    c = $fgetc(fd);
    check(c == "A", "$fgetc");
    void'($ungetc(c, fd));
    check($fgetc(fd) == "A", "$ungetc pushed the character back");
    n = $fread(word, fd);
    check(n == 2 && word == 16'h4243, $sformatf("$fread into a 16-bit variable read %0d bytes: %h", n, word));
    pos = $ftell(fd);
    check(pos == 3, $sformatf("$ftell = %0d", pos));
    void'($fseek(fd, 1, 0));
    n = $fread(mem, fd, 0, 3);
    check(n == 3 && mem[0] == "B" && mem[2] == "D", "$fread into a memory after $fseek");
    void'($rewind(fd));
    check($fgetc(fd) == "A", "$rewind");
    $fclose(fd);
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
