/*
:section: 6.6.7 User-defined nettypes
:summary: A net whose nettype has no resolution function must not have more than one driver.
:type: elaboration
:should_fail_because: a net of a nettype without a resolution function has two drivers
*/
module top;
  nettype int plain_net;
  plain_net n;
  assign n = 1;
  assign n = 2;
endmodule
