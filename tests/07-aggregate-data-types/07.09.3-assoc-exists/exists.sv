/*
:section: 7.9.3 Exists()
:summary: exists() reports 1 for an index holding an element and 0 otherwise.
*/
module top;
  int ages [string];
  initial begin
    ages["ada"] = 36;
    if (ages.exists("ada") != 1) $display("FAIL: exists() missed a stored key");
    else if (ages.exists("bob") != 0) $display("FAIL: exists() found a missing key");
    else begin
      ages.delete("ada");
      if (ages.exists("ada") != 0) $display("FAIL: exists() found a deleted key");
      else $display("PASS");
    end
    $finish;
  end
endmodule
