/*
:section: 25.7.2 Example of using tasks in modports
:summary: Interface-defined subroutines may be imported via modport, by name or by full
  prototype.
*/
interface mem_if;
  int store [4];
  task automatic put(input int a, input int v); store[a] = v; endtask
  function automatic int get(input int a); return store[a]; endfunction
  modport user(import put, import function int get(input int a));
endinterface
module cpu(mem_if.user m, output int result);
  initial begin
    m.put(2, 41);
    result = m.get(2) + 1;
  end
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  mem_if mem();
  int result;
  cpu c(.m(mem), .result(result));
  initial begin
    #1;
    check(result == 42, $sformatf("imported task and function: %0d", result));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
