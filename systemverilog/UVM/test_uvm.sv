// Sequence item
class data_t extends uvm_sequence_item /**/;
	rand int data;
	rand int addr;
endclass : data_t

// Base Sequence

// Sequence
class test_sequence extends uvm_sequence #(data_t) /* */;

	virtual task body();
		data_t dataTransaction = data_t::type_id::create("dataTransaction");
		`uvm_info("SEQUENCE", $formatf("Body: start_item call start"), UVM_MEDIUM);

		start_item(dataTransaction);
		`uvm_info("SEQUENCE", $formatf("Body: start_item call done"), UVM_MEDIUM);

		dataTransaction.randomize();
		`uvm_info("SEQUENCE", $formatf("Body: randomized transaction addr=0x%0h data=0x%0h", dataTransaction.addr, dataTransaction.data), UVM_MEDIUM);

		finish_item(dataTransaction);
		`uvm_info("SEQUENCE", $formatf("Body: finish_item call done"), UVM_MEDIUM);
	endtask : body
endclass : test_sequence

// Driver
class test_driver extends uvm_driver #(data_t) /**/;
	`uvm_component_utils(test_driver)

	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);

		`uvm_info("DRIVER", $formatf("Waiting for data from sequencer"), UVM_MEDIUM);
		seq_item_port.get_next_item(req);

		`uvm_info("DRIVER", $formatf("Start driving tx addr=0x%0h data=0x%0h", req.addr, req.data), UVM_MEDIUM);
		#20;

		`uvm_info("DRIVER", $formatf("Finish driving tx addr=0x%0h data=0x%0h", req.addr, req.data), UVM_MEDIUM);
		seq_item_port.tem_done();
	endtask : run_phase
endclass : test_driver

class test_uvm extends uvm_test /**/;

	test_driver 				m_drv0;
	uvm_sequencer #(data_t)		m_seqr0;
	test_sequence				m_seq;

	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("UVM_TEST", $formatf("Build Phase"), UVM_MEDIUM)
		m_drv0 = test_driver::type_id::create("m_drv0", this);
		m_seqr0 = uvm_sequencer#(data_t)::type_id::create("m_seqr0", this);
	endfunction : build_phase

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("UVM_TEST", $formatf("Connect Phase"), UVM_MEDIUM)
		m_drv0.seq_item_port.connect(m_seqr0.seq_item_export);
	endfunction : connect_phase

	virtual task run_phase(uvm_phase phase);
		m_seq = test_sequence::type_id::create("m_seq");
		`uvm_info("UVM_TEST", $formatf("Run Phase"), UVM_MEDIUM)
		phase.raise_objection(this);
		m_seq.start(m_seqr0);
		phase.drop_objection(this);
	endtask : run_phase
endclass : test_uvm