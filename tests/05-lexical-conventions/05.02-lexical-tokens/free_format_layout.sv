/*
:section: 5.2 Lexical tokens
:summary: Spaces and newlines only separate tokens, so source layout is free format.
*/
module helper(output int o); assign o = 5; endmodule
module
top
;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int
    total
      =
        3
          +
        4
  ;
  int from_helper ; helper u ( . o ( from_helper ) ) ;
  initial begin #1 ; check ( total == 7 , $sformatf ( "total = %0d" , total ) ) ;
    check(from_helper==5,"one-line module gave the wrong value");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
