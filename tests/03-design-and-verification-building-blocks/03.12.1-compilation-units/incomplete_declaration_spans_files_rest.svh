  int part_two = 31;
  initial begin
    if (part_one + part_two != 42) $display("FAIL: sum is %0d", part_one + part_two);
    else $display("PASS");
    $finish;
  end
endmodule
