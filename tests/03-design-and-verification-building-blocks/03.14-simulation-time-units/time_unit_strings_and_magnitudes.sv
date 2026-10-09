/*
:section: 3.14 Simulation time units and precision
:summary: Every unit from s down to fs is accepted, with magnitudes 1, 10 or 100.
:description: Each of the 18 unit strings is used by one module that waits #1; the top module
  measures every delay in femtoseconds.
:flags-verilator: -Wno-WIDTH
*/
module unit_1s(output logic done);
  timeunit 1s;
  timeprecision 1s;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_10s(output logic done);
  timeunit 10s;
  timeprecision 10s;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_100s(output logic done);
  timeunit 100s;
  timeprecision 100s;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_1ms(output logic done);
  timeunit 1ms;
  timeprecision 1ms;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_10ms(output logic done);
  timeunit 10ms;
  timeprecision 10ms;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_100ms(output logic done);
  timeunit 100ms;
  timeprecision 100ms;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_1us(output logic done);
  timeunit 1us;
  timeprecision 1us;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_10us(output logic done);
  timeunit 10us;
  timeprecision 10us;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_100us(output logic done);
  timeunit 100us;
  timeprecision 100us;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_1ns(output logic done);
  timeunit 1ns;
  timeprecision 1ns;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_10ns(output logic done);
  timeunit 10ns;
  timeprecision 10ns;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_100ns(output logic done);
  timeunit 100ns;
  timeprecision 100ns;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_1ps(output logic done);
  timeunit 1ps;
  timeprecision 1ps;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_10ps(output logic done);
  timeunit 10ps;
  timeprecision 10ps;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_100ps(output logic done);
  timeunit 100ps;
  timeprecision 100ps;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_1fs(output logic done);
  timeunit 1fs;
  timeprecision 1fs;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_10fs(output logic done);
  timeunit 10fs;
  timeprecision 10fs;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module unit_100fs(output logic done);
  timeunit 100fs;
  timeprecision 100fs;
  initial begin
    done = 0;
    #1 done = 1;
  end
endmodule

module top;
  timeunit 1fs;
  timeprecision 1fs;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic d_1s;
  unit_1s u_1s(.done(d_1s));
  initial begin @(posedge d_1s); check($time == 64'd1000000000000000, $sformatf("#1 in 1s took %0d fs", $time)); end
  logic d_10s;
  unit_10s u_10s(.done(d_10s));
  initial begin @(posedge d_10s); check($time == 64'd10000000000000000, $sformatf("#1 in 10s took %0d fs", $time)); end
  logic d_100s;
  unit_100s u_100s(.done(d_100s));
  initial begin @(posedge d_100s); check($time == 64'd100000000000000000, $sformatf("#1 in 100s took %0d fs", $time)); end
  logic d_1ms;
  unit_1ms u_1ms(.done(d_1ms));
  initial begin @(posedge d_1ms); check($time == 64'd1000000000000, $sformatf("#1 in 1ms took %0d fs", $time)); end
  logic d_10ms;
  unit_10ms u_10ms(.done(d_10ms));
  initial begin @(posedge d_10ms); check($time == 64'd10000000000000, $sformatf("#1 in 10ms took %0d fs", $time)); end
  logic d_100ms;
  unit_100ms u_100ms(.done(d_100ms));
  initial begin @(posedge d_100ms); check($time == 64'd100000000000000, $sformatf("#1 in 100ms took %0d fs", $time)); end
  logic d_1us;
  unit_1us u_1us(.done(d_1us));
  initial begin @(posedge d_1us); check($time == 64'd1000000000, $sformatf("#1 in 1us took %0d fs", $time)); end
  logic d_10us;
  unit_10us u_10us(.done(d_10us));
  initial begin @(posedge d_10us); check($time == 64'd10000000000, $sformatf("#1 in 10us took %0d fs", $time)); end
  logic d_100us;
  unit_100us u_100us(.done(d_100us));
  initial begin @(posedge d_100us); check($time == 64'd100000000000, $sformatf("#1 in 100us took %0d fs", $time)); end
  logic d_1ns;
  unit_1ns u_1ns(.done(d_1ns));
  initial begin @(posedge d_1ns); check($time == 64'd1000000, $sformatf("#1 in 1ns took %0d fs", $time)); end
  logic d_10ns;
  unit_10ns u_10ns(.done(d_10ns));
  initial begin @(posedge d_10ns); check($time == 64'd10000000, $sformatf("#1 in 10ns took %0d fs", $time)); end
  logic d_100ns;
  unit_100ns u_100ns(.done(d_100ns));
  initial begin @(posedge d_100ns); check($time == 64'd100000000, $sformatf("#1 in 100ns took %0d fs", $time)); end
  logic d_1ps;
  unit_1ps u_1ps(.done(d_1ps));
  initial begin @(posedge d_1ps); check($time == 64'd1000, $sformatf("#1 in 1ps took %0d fs", $time)); end
  logic d_10ps;
  unit_10ps u_10ps(.done(d_10ps));
  initial begin @(posedge d_10ps); check($time == 64'd10000, $sformatf("#1 in 10ps took %0d fs", $time)); end
  logic d_100ps;
  unit_100ps u_100ps(.done(d_100ps));
  initial begin @(posedge d_100ps); check($time == 64'd100000, $sformatf("#1 in 100ps took %0d fs", $time)); end
  logic d_1fs;
  unit_1fs u_1fs(.done(d_1fs));
  initial begin @(posedge d_1fs); check($time == 64'd1, $sformatf("#1 in 1fs took %0d fs", $time)); end
  logic d_10fs;
  unit_10fs u_10fs(.done(d_10fs));
  initial begin @(posedge d_10fs); check($time == 64'd10, $sformatf("#1 in 10fs took %0d fs", $time)); end
  logic d_100fs;
  unit_100fs u_100fs(.done(d_100fs));
  initial begin @(posedge d_100fs); check($time == 64'd100, $sformatf("#1 in 100fs took %0d fs", $time)); end
  initial begin
    #100s;
    #1;
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
