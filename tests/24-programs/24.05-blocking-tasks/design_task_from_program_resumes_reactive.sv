/*
:section: 24.5 Blocking tasks in cycle/event mode
:summary: A module task invoked from a program follows program scheduling and resumes in the
  Reactive region.
:timeout: 30
*/
module top;
  logic clk = 0, a = 0;
  always #5 clk = ~clk;
  always @(posedge clk) a <= ~a;
  task automatic sample(output logic v);
    @(posedge clk);
    v = a;
  endtask
  function automatic int square(int x); return x * x; endfunction
  tb t();
endmodule
program tb;
  initial begin
    logic v1, v2;
    top.sample(v1);
    top.sample(v2);
    if (v1 !== 1'b1 || v2 !== 1'b0)
      $display("FAIL: design task called from a program sampled %b %b before the design's nonblocking updates", v1, v2);
    else if (top.square(4) != 16)
      $display("FAIL: design function called from a program");
    else
      $display("PASS");
    $finish;
  end
endprogram
