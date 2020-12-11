//  Class: test
//
class test extends uvm_component;
  `uvm_component_utils(test);

  //  Group: Configuration Object(s)


  //  Group: Components


  //  Group: Variables


  //  Group: Functions

  //  Constructor: new
  function new(string name = "test", uvm_component parent);
    super.new(name, parent);
  endfunction: new

  /*---  UVM Build Phases            ---*/
  /*------------------------------------*/
  //  Function: build_phase
  extern function void build_phase(uvm_phase phase);
  //  Function: connect_phase
  extern function void connect_phase(uvm_phase phase);
  //  Function: end_of_elaboration_phase
  extern function void end_of_elaboration_phase(uvm_phase phase);

  /*---  UVM Run Phases              ---*/
  /*------------------------------------*/
  //  Function: start_of_simulation_phase
  extern function void start_of_simulation_phase(uvm_phase phase);
  //  Function: reset_phase
  extern task reset_phase(uvm_phase phase);
  //  Function: configure_phase
  extern task configure_phase(uvm_phase phase);
  //  Function: main_phase
  extern task main_phase(uvm_phase phase);
  //  Function: shutdown_phase
  extern task shutdown_phase(uvm_phase phase);

  /*---  UVM Cleanup Phases          ---*/
  /*------------------------------------*/
  //  Function: extract_phase
  extern function void extract_phase(uvm_phase phase);
  //  Function: report_phase
  extern function void report_phase(uvm_phase phase);
  
endclass: test

/*----------------------------------------------------------------------------*/
/*  UVM Build Phases                                                          */
/*----------------------------------------------------------------------------*/
function void test::build_phase(uvm_phase phase);
  /*  note: Do not call super.build_phase() from any class that is extended from an UVM base class!  */
  /*  For more information see UVM Cookbook v1800.2 p.503  */
  // super.build_phase(phase);
endfunction: build_phase


function void test::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction: connect_phase


function void test::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction: end_of_elaboration_phase


/*----------------------------------------------------------------------------*/
/*  UVM Run Phases                                                            */
/*----------------------------------------------------------------------------*/
function void test::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction: start_of_simulation_phase


task test::reset_phase(uvm_phase phase);
endtask: reset_phase


task test::configure_phase(uvm_phase phase);
endtask: configure_phase


task test::main_phase(uvm_phase phase);
endtask: main_phase


task test::shutdown_phase(uvm_phase phase);
endtask: shutdown_phase


/*----------------------------------------------------------------------------*/
/*  UVM Cleanup Phases                                                        */
/*----------------------------------------------------------------------------*/
function void test::report_phase(uvm_phase phase);
  super.report_phase(phase);
endfunction: report_phase


function void test::extract_phase(uvm_phase phase);
  super.extract_phase(phase);
endfunction: extract_phase

