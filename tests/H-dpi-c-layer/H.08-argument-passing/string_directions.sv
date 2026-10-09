/*
:section: H.8.10 String arguments
:summary: DPI strings reach C null-terminated, output strings arrive empty, and inout strings
  pass both ways.
:dpi: string_directions.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function int c_strlen(input string s);
  import "DPI-C" function void c_name(output string s);
  import "DPI-C" function void c_upgrade(inout string s);
  string out, io = "old";
  initial begin
    check(c_strlen("seven!!") == 7, "input string is null-terminated");
    c_name(out);
    check(out == "from C", $sformatf("output string '%s'", out));
    c_upgrade(io);
    check(io == "old+new", $sformatf("inout string '%s'", io));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
