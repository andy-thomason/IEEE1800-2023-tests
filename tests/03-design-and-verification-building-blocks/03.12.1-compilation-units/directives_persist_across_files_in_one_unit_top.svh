module top;
  initial begin
    if (`DEPTH_FROM_FIRST_FILE != 12) $display("FAIL: macro value is wrong");
    else $display("PASS");
    $finish;
  end
endmodule
