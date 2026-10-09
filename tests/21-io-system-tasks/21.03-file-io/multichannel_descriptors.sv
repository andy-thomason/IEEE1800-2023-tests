/*
:section: 21.3.1 Opening and closing files
:summary: Multichannel descriptors from $fopen use one distinct bit each, bit 0 is stdout, and
  ORed values write everywhere.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int mcd1, mcd2, fd;
  string a, b;
  initial begin
    mcd1 = $fopen("mcd_one.txt");
    mcd2 = $fopen("mcd_two.txt");
    check($countones(mcd1) == 1 && $countones(mcd2) == 1 && mcd1 != mcd2 && mcd1[31] == 0, "single-bit descriptors");
    $fdisplay(mcd1 | mcd2, "shared line");
    $fclose(mcd1 | mcd2);
    fd = $fopen("mcd_one.txt", "r"); void'($fgets(a, fd)); $fclose(fd);
    fd = $fopen("mcd_two.txt", "r"); void'($fgets(b, fd)); $fclose(fd);
    check(a == "shared line\n" && b == a, "write to two files at once");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
