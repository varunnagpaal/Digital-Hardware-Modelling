uvm_object
-
uvm_transaction
- IS-A kind of uvm_object

uvm_report_object
- IS-A kind of uvm_object

uvm_reg_block
- IS-A kind of uvm_object

uvm_sequence_item
- IS-A kind of uvm_transaction representing a transaction such as a packet

uvm_component
- IS-A kind of uvm_report_object
- is configurable using a configuration object

configuration object
- Contains handle to virtual interface common to the DUT

uvm_sequence
- IS-A kind of uvm_sequence_item which HAS-A collection of uvm_sequence_item 's
- Has a pre-body (virtual task that consumes time) where we raise an objection to let the testbench
  know that the sequence has items still pending for execution 
- Has a body phase (virtual task that consumes time) where we loop over a block which calls 
  - start_item(handle_sequence_item_obj)
  - some code
  - finish_item(handle_sequence_item_obj) 
  to send data demanded by the driver. Start item starts only after the driver calls 
  seq_item_port.get_next_item(handle_sequence_item_obj) and finish_item finishes only
  after the driver calls seq_item_port.item_done()
- Has a post-body (virtual task that consumes time) where we drop the raised objection

uvm_sequencer
- IS-A kind of uvm_component which supplies uvm_sequence_item from the uvm_sequence on demand to the uvm_driver in a pre-determined sequence.
- It is generally instantiated in the uvm_env with type parameter of type uvm_sequence_item

uvm_driver
- IS-A kind of uvm_component which gets uvm_sequence from uvm_sequencer and drives it into DUV interface as i/o signals. Also called bus functional model.
- Has a reset_phase task (consumes simulation time) where we do DUT reset via the virtual interface wrapped between uvm_phase.raise_objection() and uvm_phase.drop_objection() 
- Has a main_phase task  (consumes simulation time) where we 
  - first get next sequence_item by calling uvm_driver.seq_item_port.get_next_item (handle_sequence_item_obj)
  - then call user defined virtual task such as uvm_driver.drive_item(handle_sequence_item_obj) which extracts pin values 
    from the handle_sequence_item_obj and applies them to DUT puns via the virtual interface
  - then call uvm_driver.seq_item_port.item_done()

uvm_monitor
- IS-A kind of uvm_component which observes rtl i/o signals at the DUT interface and converts 
  them into uvm_sequence and sends the individual uvm_sequence_item out to other components
  (say uvm_scoreboard) from its analysis port.
- has an
  - analysis port templated to the uvm_sequence_item
  - has a main_phase task which consumes time which calls a 
    user defined virtual task say collect_transaction
    where it builds handle_sequence_item_obj transaction by
    observing  the DUT rtl i/o signals via the virtual interface 
    and sends it out to the scoreboard by calling write(handle_sequence_item_obj)
    function of its analysis port

uvm_scoreboard
- IS-A kind of uvm_component which has an 
  - analysis port templated to uvm_sequence_item and uvm_scoreboard
  - export (data_export)
  - write_data(handle_sequence_item_obj) function through which monitor sends it the 
    handle_sequence_item_obj it reconstructed from DUT RTL I/O Signals
  - compares the actual output of the dut in handle_sequence_item_obj it received from monitor
    to the expected output corresponding to the input in handle_sequence_item_obj and gives 
    a decision if pass or fail.

uvm_subscriber
- IS-A kind of uvm_component which

uvm_agent
- IS-A kind of uvm_component which HAS-A instances of uvm_driver, uvm_sequencer, uvm_monitor
- Needs a handle to the virtual interface to the DUV which is the mechanism by which uvm_agent.uvm_driver connects to the  
- Can be active or passive. 
  - Active means it mainly control DUV via its interface through uvm_sequencer and uvm_driver.
  - Passive means it mainly observes DUV via its interface through uvm_monitor.
- Is instantiated in instance of uvm_env. Typically one agent per interface.


uvm_env
- IS-A kind of uvm_component which HAS-A instance collection of uvm_agent 's, typically one agent instance per DUV interface.
- May configure itself using its configuration object and further uses its configuration to configure its agent instance(s)
- May have multiple instance of uvm_sequence

uvm_test
- IS-A kind of uvm_component which HAS-A instance of uvm_env