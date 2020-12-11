class my_driver extends uvm_driver #(my_transaction);

  `uvm_component_utils(my_driver)

  virtual dut_if dut_vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info("UVM_DRIVER", "Build Phase Started", UVM_MEDIUM);
    // Get interface reference from config database
    if(!uvm_config_db#(virtual dut_if)::get(this, "", "dut_vif", dut_vif)) begin
      `uvm_error("", "uvm_config_db::get failed")
    end
    `uvm_info("UVM_DRIVER", "Build Phase Ended", UVM_MEDIUM);
  endfunction 

  task run_phase(uvm_phase phase);
    `uvm_info("UVM_DRIVER", "Run Phase Started", UVM_MEDIUM);
    // First toggle reset
    dut_vif.reset = 1;
    @(posedge dut_vif.clock);
    #1;
    dut_vif.reset = 0;
    
    // Now drive normal traffic
    forever begin
      `uvm_info("UVM_DRIVER", "Before get_next_item", UVM_MEDIUM);
      seq_item_port.get_next_item(req);
      `uvm_info("UVM_DRIVER", "After seq_item_port.get_next_item", UVM_MEDIUM);

      // Wiggle pins of DUT
      dut_vif.cmd  = req.cmd;
      dut_vif.addr = req.addr;
      dut_vif.data = req.data;
      @(posedge dut_vif.clock);

      `uvm_info("UVM_DRIVER", "Before seq_item_port.item_done", UVM_MEDIUM);
      seq_item_port.item_done();
      `uvm_info("UVM_DRIVER", "After seq_item_port.item_done", UVM_MEDIUM);
    end
    
    `uvm_info("UVM_DRIVER", "Run Phase Ended", UVM_MEDIUM);
  endtask

endclass: my_driver
