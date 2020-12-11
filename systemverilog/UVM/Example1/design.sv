// This is the SystemVerilog interface that we will use to connect
// our design to our UVM testbench.
interface dut_if;
  logic clock, reset;
  logic cmd;
  logic [7:0] addr;
  logic [7:0] data;
endinterface

`include "uvm_macros.svh"

// This is our design module.
// 
// It is an empty design that simply prints a message whenever
// the clock toggles.
module dut(dut_if dif);
  import uvm_pkg::*;
  always @(posedge dif.clock)
    if (dif.reset != 1) begin
      `uvm_info("DUT",
                $sformatf("Received cmd=%b, addr=0x%2h, data=0x%2h",
                          dif.cmd, dif.addr, dif.data), UVM_MEDIUM)
    end
endmodule
