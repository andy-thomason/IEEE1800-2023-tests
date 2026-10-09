/*
:section: 5.9 String literals
:summary: Triple-quoted strings accept literal newlines and double quotes without escaping, and
  still honour escape sequences.
:description: Triple-quoted strings are new in IEEE 1800-2023.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string with_newline = """up
down""";
  string with_quote = """say "yes" now""";
  string continued = """left\
right""";
  string escaped = """tab\there""";
  initial begin
    check(with_newline == {"up", 8'd10, "down"}, $sformatf("raw newline: \"%s\"", with_newline));
    check(with_quote == {"say ", 8'd34, "yes", 8'd34, " now"}, $sformatf("raw quotes: \"%s\"", with_quote));
    check(continued == "leftright", $sformatf("escaped newline: \"%s\"", continued));
    check(escaped == {"tab", 8'd9, "here"}, "escape sequences do not work in triple-quoted strings");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
