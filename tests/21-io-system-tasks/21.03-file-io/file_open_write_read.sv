/*
:section: 21.3.1 Opening and closing files
:summary: $fopen returns a nonzero descriptor on success or zero on failure, enabling writes,
  reads and closing.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int fd, n, r;
  string line;
  int v1, v2;
  initial begin
    fd = $fopen("io_test.txt", "w");
    check(fd != 0, "could not open a file for writing");
    $fdisplay(fd, "first %0d", 11);
    $fwrite(fd, "12 34\n");
    $fclose(fd);
    check($fopen("no/such/dir/file.txt", "r") == 0, "opening a missing file did not return 0");
    fd = $fopen("io_test.txt", "r");
    n = $fgets(line, fd);
    check(line == "first 11\n" && n == 9, $sformatf("$fgets read '%s' (%0d)", line, n));
    r = $fscanf(fd, "%d %d", v1, v2);
    check(r == 2 && v1 == 12 && v2 == 34, "$fscanf");
    void'($fgetc(fd));
    check($fgetc(fd) == -1 && $feof(fd) != 0, "end of file");
    $fclose(fd);
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
