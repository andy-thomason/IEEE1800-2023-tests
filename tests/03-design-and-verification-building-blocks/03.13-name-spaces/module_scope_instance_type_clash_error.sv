/*
:section: 3.13 Name spaces
:summary: Inside a module, an instance name cannot duplicate a typedef name.
:type: elaboration
:should_fail_because: an instance name and a type name share the module name space
*/
module leaf;
endmodule

module top;
  typedef logic [3:0] u_leaf;
  leaf u_leaf();
endmodule
