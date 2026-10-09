/*
:section: 5.12 Attributes
:summary: Attributes may prefix declarations, module items, statements and ports, or follow
  operators and function names.
:description: Attributes on a module, declarations, an instance, a port connection, statements, an
  operator and a function call do not change behaviour.
*/
(* keep_hierarchy *)
module adder(input int a, b, output int s);
  assign s = a + (* impl = "ripple" *) b;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  (* watch, weight = 3 *) int x = 4;
  int y, z, sel = 2;
  function automatic int twice(int v);
    return 2 * v;
  endfunction
  (* placement = "left" *)
  adder u_add(.a(x), (* hint *) .b(5), .s(y));
  initial begin
    #1;
    (* note = "check" *)
    check(y == 9, $sformatf("adder output %0d", y));
    z = twice (* inline *) (x);
    check(z == 8, "attribute on a function call");
    z = (sel > 1) ? (* no_glitch *) 1 : 0;
    check(z == 1, "attribute on a conditional operator");
    (* full_case, parallel_case = 1 *)
    case (sel)
      2: z = 20;
      default: z = 0;
    endcase
    check(z == 20, "attribute on a case statement");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
