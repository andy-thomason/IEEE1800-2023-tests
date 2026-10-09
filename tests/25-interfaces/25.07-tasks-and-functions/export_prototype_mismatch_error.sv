/*
:section: 25.7 Tasks and functions in interfaces
:summary: A module definition of an exported task must exactly match the modport prototype.
:type: elaboration
:should_fail_because: the exported task has an extra argument
*/
interface link_if;
  modport server(export task serve(input int x));
endinterface
module server_m(link_if.server s);
  task s.serve(input int x, input int extra);
  endtask
endmodule
module top;
  link_if l();
  server_m srv(.s(l));
endmodule
