/*
:section: 6.7.1 Net declarations with built-in net types
:summary: Nets accept any four-state type and default to logic when only range or signing
  appears.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef logic [11:0] addr_t;
  typedef struct packed { logic flag; logic [6:0] data; } packet_t;
  wire addr_t w_addr = 12'hABC;
  wire packet_t w_packet = {1'b1, 7'd5};
  wire w_plain;
  wire [9:0] w_range = 10'bz;
  wire logic [3:0] w_array [2];
  assign w_array[0] = 4'd3;
  assign w_array[1] = 4'd4;
  initial begin
    #1;
    check($bits(w_addr) == 12 && w_addr == 12'hABC, "net of a typedef type");
    check(w_packet.flag === 1'b1 && w_packet.data == 5, "net of a packed struct type");
    check($bits(w_plain) == 1 && w_plain === 1'bz, "implicit logic scalar net");
    check($bits(w_range) == 10 && w_range === 10'bz, "implicit logic vector net holds z");
    check(w_array[0] + w_array[1] == 7, "unpacked array net");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
