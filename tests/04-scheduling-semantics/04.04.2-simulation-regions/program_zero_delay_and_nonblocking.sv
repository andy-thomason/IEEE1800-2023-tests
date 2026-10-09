/*
:section: 4.4.2.7 Re-Inactive events region
:summary: Inside a program, #0 resumes in Re-Inactive and nonblocking updates land in Re-NBA,
  both later.
*/
program prog;
  int pv = 0;
  int errors = 0;
  initial begin
    pv <= 7;
    if (pv != 0) begin $display("FAIL: program nonblocking update was immediate"); errors++; end
    #0;
    if (pv != 0) begin $display("FAIL: Re-NBA update happened before the Re-Inactive region"); errors++; end
    #1;
    if (pv != 7) begin $display("FAIL: program nonblocking update never happened"); errors++; end
    if (errors == 0) $display("PASS");
    $finish;
  end
endprogram

module top;
  prog u_prog();
endmodule
