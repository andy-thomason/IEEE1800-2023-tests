/*
:section: 7.8.5 Other user-defined types
:summary: Any type with equality defined, including structs and queues, may index an associative
  array.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct { byte tag; int list []; } key_t;
  typedef int seq_t [$];
  int by_struct [key_t];
  int by_queue [seq_t];
  key_t k1, k2;
  seq_t q, probe, empty_q;
  initial begin
    k1.tag = 1; k1.list = '{1, 2};
    k2.tag = 1; k2.list = '{};
    by_struct[k1] = 10;
    by_struct[k2] = 20;
    check(by_struct.num() == 2 && by_struct[k1] == 10 && by_struct[k2] == 20, "struct index with a dynamic member (incl. empty)");
    q = '{3, 4};
    by_queue[q] = 5;
    by_queue[empty_q] = 6;
    probe = '{3, 4};
    check(by_queue[probe] == 5 && by_queue[empty_q] == 6 && by_queue.num() == 2, "queue index (incl. empty)");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
