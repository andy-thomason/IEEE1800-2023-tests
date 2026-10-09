/*
:section: 21.3.7 I/O error status
:summary: $ferror returns the error code of the latest file operation and writes a matching
  description string.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int fd, err;
  string msg;
  initial begin
    fd = $fopen("err_test.txt", "w");
    $fdisplay(fd, "ok");
    err = $ferror(fd, msg);
    check(err == 0 && msg == "", $sformatf("no error expected, got %0d '%s'", err, msg));
    $fclose(fd);
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
