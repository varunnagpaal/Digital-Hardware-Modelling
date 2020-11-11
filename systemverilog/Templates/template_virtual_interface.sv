////////////////////////////////////////////////////////////////////////////////
// Module Name  : template_virtual_interface
// File name    : template_virtual_interface.sv
// Description  : Template for SystemVerilog Virtual Interface facilties
// Type         : 
// Limitations  : None
// Model Styles : 
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 16/10/2020
////////////////////////////////////////////////////////////////////////////////

/* 
  Transaction
  - Transfer of Data between design blocks
  - Composed of many signal transitions over multiple clock cycles
  - Easier to work at this higher level of abstraction then at signal level
    - Easy to design, create, analyze, debug, maintain transactions instead of individual signals
  - Can have parameters such as address, data etc.
  - Often used in script-driven testbenche verification (Transaction Based )
  - Requires well defined interfaces for the design and verification environment.

  Transaction Based Verification
  - System based verification at abstraction level of transactions instead 
    of bunch of individual signals. It has three main parts
    - DUT
      - RTL Module under verification.
    - Sequences or Stimulus
      - Stimulus pattern in form of high-level transactions abstracted from the bus
        protocol. It forms the test data set that is to be driven into a DUT
    - Verification Component
      - Reads one transaction at a time from Sequencer and drives them in a 
        pre-determined order into the interface of the DUT in form of RTL i/o 
        signals.
      - Performs translation between transactions from sequencer and RTL i/o
        signals at the DUT interface.
      - Has upto three sub-components
        - Sequencer or Stimulus Generator
          It pulls transactions from sequences and synchronizes with the driver
          to control the order in which driver will feed stimulus into the DUT.
          It provides transaction ordering facilities in form of randomization.
        - Driver or Bus functional model (BFM)
          Emulates a component that drives a DUT via a set of i/o signals called Bus.
          It provides conversion between high-level transactions from/to sequencer 
          and low level signals to/from the DUT interface.
        - Monitor or Collector
          A passive component which observes the RTL signal I/O activity on the
          interface of the DUT to reconstruct the transaction being carried out
          on the interface by the sequencer-driver. The reconstructed transaction 
          is sent to another component called Scoreboard which performs analysis 
          such as checking, code coverage, functional coverage etc.
      - For reusability and maintaibility, VCs and Sequences are created with 
        SystemVerilog classes specifically using class library such as UVM.
      - One VC for every bus or interface protocol in the design.
      - VC for common bus protocol are availbale as VIP (Verification IP) from 
        EDA vendors
    
  Virtual Interfaces
  - VCs drive and monitor RTL i/o signals of DUT via an interface.
  - However VCs should not be connected directly to a DUT interface
    This is because of following issues:
    - VC class which is designed to drive-monitor a specific interface type 
      of a DUT cannot be reused to drive-monitor DUTs with separate instance
      of same interface type. This prevents reusability of a VC which is 
      a SystemVerilog class.
    - Ideally a VC class should be a reusable model in the sense that 
      it should be possible to create multiple instances of VC should
      each specialized to drive-monitor a different interface instances
      a given interface type
  - The elegant solution to the problem with connecting VCs directly to
    a specific interface instance is to instead use virtual interfaces. 
    The VC is designed with virtual interface of specific interface type
    and during instantiation of VC the virtual interface is mapped to 
    an instance of the same interface type. A handle to virtual interface 
    of an interface type can be created as member property of the VC class
    thereby allowing the VC to internally accesses the RTL signals 
    of the DUT via instance of the same interface type through hierarhichal
    syntax such as virtual_interface.hierachy_path_to_dut_signal.
  - Reading/writing nets and variables through a virtual interface
    - variable type : read or written (assigned) via a virtual interface
    - logic type    : read or written (assigned) via a virtual interface
    - net type      : read but CANNOT be written (driven) via virtual interfaces    
  - To make an existing SV interface as a virtual interface member property
    of a module, use prefix "virtual interface" when declaring the interface
    handle as member property. Interface keyword is optional but recommended
  - Unless a virtual interface variable is assigned, its value is null.
  - A virtual interface can be assigned or compared to
    - Another virtual interface
    - null
    - Instance of itself  
  - A virtual interface can be declared as a
    - class member property
      - must be assigned a value in either
          - class constructor new()
          - class method
          - directly assigned
    - argument of a task/function
    - module variable
*/

//  Interface: if_bus
interface if_bus( input clk );
  logic req, gnt, start, rdy;
  logic [1:0] mode;
  logic [7:0] addr;
  wire  [7:0] data;

  // Modport: slave
  modport slave(
    input  logic req, start,
           logic [1:0] mode,
           logic [7:0] addr,
    inout  wire [7:0] data,
    output logic gnt, rdy );

  // Modport: master
  modport master(
    input   logic gnt, rdy,
    inout   wire  [7:0] data,
    output  logic req, start
            logic [1:0] mode,
            logic [7:0] addr );
endinterface //if_bus

/* Example 1: Virtual Interface in a module */
module template_virtual_interface;

  logic clk = 0;

  // instances of the interface
  if_bus bus1(clk);
  if_bus bus2(clk);

  // Virtual interface of type if_bus as a module variable 
  // NOTE: interface keyword is optional
  virtual interface if_bus vIfbus;

  // Task based on virtual interface type if_bus
  // NOTE: interface keyword is optional
  task read(input logic [7:0] inAddr,
            output logic [7:0] outData,
            virtual interface if_bus vBus);
    
    @(negedge clk)
      vBus.mode = 2'b00;
      vBus.req = 1;
    
    @(posedge clk)
      if( vBus.gnt && vBus.rdy ) begin
        vBus.address = inAddr;
        outData = vBus.data;
      end
  endtask: read
  
  // Task based on virtual interface type if_bus
  // NOTE: interface keyword is optional  
  task write(input logic [7:0] inAddr,
                   logic [7:0] inData,
              virtual interface if_bus vBus);

    @(negedge clk)
      vBus.mode <= 2'b10;
      vBus.req <= 1;

    @(posedge clk)
      if( vBus.gnt && vBus.rdy ) begin
        vBus.address <= inAddr;
        vBus.data <= inData;
      end
    endtask: read

  initial begin
    vIfbus = bus1;                // assigning bus1 - an instance of the same interface as if_bus- to the virtual interface module member

    logic [7:0] myData = 8'hF0;
    write (8'h0F, myData+3, bus2);  // passing bus2 to virtual interface argument 
    read (8'h1F, myData, vIfbus);   // passing virtual interface handle (assigned to bus1) to virtual interface argument 

  end
endmodule: template_virtual_interface

/* Example 2: Virtual Interface in a SV class */
class bfm_model;
  // declaring virtual interface of the interface type if_bus as a menber poperty. 
  // Its default value is null.
  virtual interface if_bus vIfBus;

  // virtual interface member property assigned to an instance of same
  // interface type which is passed as argument to the class constructor
  function new(virtual interface if_bus vBus);
      vIfBus = vBus;                
  endfunction //new()

  // virtual interface manipulated by class method
  task write(input logic [7:0] inAddress, inData);
    @(posedge clk)
      vIfBus.address <= inAddress;
      vIfBus.data <= inData;
  endtask: name  
endclass //bfm_model

//  Module: test
module test;
  logic clk = 0;

  if_bus bus1(clk), bus2(clk);
  bfm_model bfm1, bfm2;

  initial begin
    bfm1 = new(bus1);
    bfm1.write(8'hE1, 8'hFF);

    bfm2 = new(bus2);
    bfm1.read(8'h11, 8'h0F);
  end
  
endmodule: test

/*
  Problem of writing to interface nets via virtual interface
    - bidirectional inout net types(wire) ports of a DUT can only be read 
      but cannot be written(driven) via virtual interface as virtual interface
      are manipulated via procedural assignments. Nets can only 
      be driven through continuous assignment statements but not from procedures.
*/ 

/* Workaround 1 to the Problem of writing to interface nets via virtual interface
  - Create an alias of logic type signal for the net type signal in the
    interface and write to the logic type signal via virtual interface.
*/
interface rdwrNetWorkaroundIf (input logic clk);
  wire [16:0] wData;  // can only be read but not written driven via virtual interface
  logic [16:0] Data;  // an alias of above net which can be read or written (driven) via virtual interface

  // Workaround: a net type bidirectional signal port can still be
  // driven inside the interface even if it cannot be driven via a
  // virtual interface. So we create an logic type alias of the net
  //  type (as below) and instead drive the logic type via virtual 
  // interface such that then the interface would indirectly drive 
  // the net type using the value of the alias logic type driven
  // via the virtual interface.
  assign wData = Data;
endinterface: rdwrNetWorkaroundIf

module test
  logic clk = 0;
  virtual interface rdwrNetWorkaroundIf myBusIf;
  initial begin
    @(posedge clk)
    myBusIf.wData <= 16'hFF01;  // compiler error: virtual interface cannot drive a net type but only read it
    myBusIf.Data <= 16'hFF01;   // ok: wData indirectly driven via Data by interface while Data driven via virtual interface
  end  
endmodule: test

/* Workaround 2 to the Problem of writing to interface nets via virtual interface
  - Use a clocking block inside an interface
  - signals now accessed via clocking block via virtual interface
  - procedural assignment to net is allowed via a clocking block

  Guideline #9 
  - Declare your clocking block in an interface. 
  - Expose the clocking block, and any asynchronous signals that are directly
    related to it, through a modport of the interface.
  - In your verification code, declare a virtual interface data type that can
    reference that modport. This is to ensure that testbench cannot get to
    the interface directly but only via the modport.
  
    - Clocking block inside an interface along with signals within that 
      clocking block can be accessed using hierarchichal member access
      expression for the interface instance or for the virtual interface: 
      - <interf_instance>.<clk_blk>.<sig.name>
      - <virtual_interf>.<clk_blk>.<sig.name>
*/
`timescale 1ns/100ps; // = #1/#1step

interface if_bus_cb(input logic clk, reset_async_n)
  wire [15:0] wData;  // net type bi-directional

  clocking cb1 @(posedge clk);  // active clicking block event
    default input   #1          // input skew default: -1
            output  #2;         // output skew default: +2
    
    // signal direction declaration with optional explicit skew
    input wData;  // bi-directional signal
    output wData; // bi-directional signal
  endclocking: cb1

  // User of virtual interface use modport to expose clocking block
  // (clock event synched clockvars) and any async signals that donot
  // go through clocking block.
  // NOTE: direction not specified for cb in modport as cb internally
  // defines signal directions relative to the testbench
  modport databus(clocking cb1,
                  input reset_async_n)

endinterface: if_bus_cb

class bfm_model;
  virtual interface if_bus_cb.databus vIfDataBusCb;

  function new( virtual interface if_bus_cb.databus vDataBusCb);
    vIfDataBusCb = vDataBusCb;
  endfunction //new()

  task write(input logic [7:0] inAddress, inData);
    @vIfDataBusCb.cb1
      vIfDataBusCb.address = inAddress;
      vIfDataBusCb.data = inData;
  endtask: name  
endclass //bfm_model

module test;
  logic clk = 0;

  if_bus bus1(clk), bus2(clk);
  bfm_model bfm1, bfm2;

  initial begin
    bfm1 = new(bus1);
    bfm1.write(8'hE1, 8'hFF);

    bfm2 = new(bus2);
    bfm1.read(8'h11, 8'h0F);
  end
  
endmodule: test

