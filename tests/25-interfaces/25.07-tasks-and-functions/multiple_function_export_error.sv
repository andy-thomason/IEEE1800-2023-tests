/*
:section: 25.7.4 Example of multiple task exports
:summary: A function may not be exported by more than one module.
:type: elaboration
:should_fail_because: two modules export the same function
*/
interface fn_if;
  extern function int answer();
  modport target(export answer);
endinterface
module target_m(fn_if.target t);
  function int t.answer(); return 1; endfunction
endmodule
module top;
  fn_if bus();
  target_m a(.t(bus));
  target_m b(.t(bus));
endmodule
