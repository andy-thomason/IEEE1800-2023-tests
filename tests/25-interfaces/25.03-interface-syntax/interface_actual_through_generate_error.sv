/*
:section: 25.3 Interface syntax
:summary: An interface port actual must not reach the interface instance through a generate
  block.
:type: elaboration
:should_fail_because: the interface actual resolves through a generate block
*/
interface simple_if; logic x; endinterface
module user(simple_if p); endmodule
module top;
  for (genvar g = 0; g < 2; g++) begin : gen
    simple_if inst();
  end
  user u(.p(gen[0].inst));
endmodule
