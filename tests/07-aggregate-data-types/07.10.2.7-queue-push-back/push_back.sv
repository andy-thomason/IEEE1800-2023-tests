/*
:section: 7.10.2.7 Push_back()
:summary: push_back() appends each new item to the end of a queue.
*/
module top;
  int q [$];
  initial begin
    q.push_back(4);
    q.push_back(8);
    q.push_back(15);
    if (q.size() != 3) $display("FAIL: size is %0d", q.size());
    else if (q[0] != 4 || q[1] != 8 || q[2] != 15) $display("FAIL: order is %p", q);
    else $display("PASS");
    $finish;
  end
endmodule
