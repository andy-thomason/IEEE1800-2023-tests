/*
:section: 14.11 Cycle delay: ##
:summary: Using ## without any default clocking in scope is an error.
:type: elaboration
:should_fail_because: ## is used without a default clocking
*/
module top;
  initial ##2 $display("done");
endmodule
