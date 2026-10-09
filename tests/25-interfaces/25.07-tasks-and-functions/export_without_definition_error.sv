/*
:section: 25.7 Tasks and functions in interfaces
:summary: A module connected to an exporting modport must define the exported subroutine.
:type: elaboration
:should_fail_because: the module connected to an exporting modport does not define the task
*/
interface link_if;
  modport server(export task serve(input int x));
endinterface
module server_m(link_if.server s);
endmodule
module top;
  link_if l();
  server_m srv(.s(l));
endmodule
