/*
:section: 7.6 Array assignments
:summary: Unpacked arrays are assigned element by element in left-to-right order, resizing
  dynamic targets.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int down [5:1];
  int up [1:5];
  int dyn [];
  int q [$];
  string parts [3] = '{"x", "y", "z"};
  string joined [];
  logic [7:0] vars_in [3];
  logic [7:0] vars_out [1:3];
  wire [7:0] nets [2:0];
  assign nets = vars_in;
  initial begin
    foreach (up[i]) up[i] = i * 10;
    down = up;
    check(down[5] == 10 && down[1] == 50, "left-to-right element correspondence");
    dyn = up;
    check(dyn.size() == 5 && dyn[0] == 10, "dynamic target resized");
    q = down[4:2];
    check(q.size() == 3 && q[0] == 40, "queue target from a slice");
    joined = {parts[0:1], "mid", parts[2]};
    check(joined.size() == 4 && joined[2] == "mid" && joined[3] == "z", "unpacked concatenation into a dynamic array");
    vars_in = '{8'd1, 8'd2, 8'd3};
    #1 vars_out = nets;
    check(vars_out[1] == 1 && vars_out[3] == 3, "array of nets to array of variables");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
