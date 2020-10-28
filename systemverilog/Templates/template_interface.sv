////////////////////////////////////////////////////////////////////////////////
// Module Name  : template_interface
// File name    : template_interface.sv
// Description  : Template for SystemVerilog Interfaces
// Type         : 
// Limitations  : None
// Model Styles : 
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 14/10/2020
////////////////////////////////////////////////////////////////////////////////

/* SV Interfaces 
  - can contain synthesizable constructs such as 
    - mandatory set of nets and variables grouped as a type (like a C struct)
    - optional protocol functionality in form of functions (zero delay, zero clock cycle)
    - optional module port (Modport) definitions which is a subset of interface signals 
      with signal directions.
  - can contain non-synthesizable constructs for Transaction level and Verification such as 
    - its own i/o ports
    - continuous assignments
    - tasks, functions
    - initial/always blocks
    - assertions
  - CANNOT declare or instantiate modules, primitives, specify blocks, configurations
  - placed in a separate file and compiled by simulator
  - can be instantiated 
    - inside a module eg: instead of creating module i/o ports or internal i/o nodes
      of type nets and variables, one can create an interface which contains those 
      nets and variables and instantiate that interface
    - using generate statements or in arrays
    - within other interfaces i.e nested interfaces are supported!
  - can act as a port type
  - can be parameterized
  - member nets or variables of an Interface can be from its interface instance
  - Applications: 
      - Define ports as interface instance instead of individual nets/vars
      - When conecting instances of two modules, use port of type interface instance
        over port of type nets.
      - Model Buses with Master Slave devices: A standard bus in form of module is
        connected to multiple master/slave modules such as bus can be represented
        by instance of an interface and other modules may connect to the bus through
        ports defined as instance of same interface.

  - Modport of an Interface
    - view of an interface which is a subset of its signals along with signal directions.
    - it is defined within the interface definition.
    - no limit on defining number of modports for an interface.
    - there are two ways to define ports of a module as type of interface modport 
      - during module declaration of module: port defined as type of an interface modport
      - during module insantiation 
        - module should first defines its port as a type of parent interface of the target modport
        - bind or map the target modport of the parent interface during module instantiation
        - this gives the flexibility to create instances of same module with various modports

  - Interface Methods
    - A SV task defined as part of an interface which can perform read/write operations on 
      the interface signals is called as an Interface Method.
    - Any module which uses an interface for making interconnection can also access the 
      interface methods aka tasks defined within that interface definition.
    - The call to the interface method aka interface task is made using syntax
      - interface_object.taskname(task_argument_values)
    - Typical operations on interface signals such as read/write are generally defined as part
      of a testbench. Instead SV allows defining tasks as part of an interface called as 
      Interface Method. This enables sharing the same task among instances of various modules
      whose ports are based on the interface. This also prevents copying similar tasks to 
      various module and thus reduces maintenance.

  - Generic Interface Reference
    - declare a module port type with keyword "interface" rather than using a specific
      pre-defined interface type.
    - This acts as a placeholder for an interface type.
    - Later during module instantiation, the module port can be bound to specific interface type 
    - this allows same module to be used with different interface types each of which may implement
      may have different set of signals, modports, coverage, assertions, custom tasks, functions etc.
    - generic interface reference are only supported using named-port connections syntax
    - also note that module which has a port defined as a generic interface reference cannot just 
      connect using this generic interface and must be bound to a specific interface type 
      which consists of signals, interface methods etc that are referenced within the module
      via the interface port name
*/

/* Example 1: Modules memory, cpucore and top without interface */
  //  Module: memory without Interface
  module memory
    (
      input   logic clk, req, start,
              logic [1:0] mode,
              logic [7:0] addr,
      inout   wire [7:0] data,
      output  logic gnt, rdy
    );
  
  always_ff @(posedge clk) begin
    ...      
  end

  endmodule: memory

  //  Module: cpucore without Interface
  module cpucore
    (
      input   logic clk, gnt, rdy,
      inout   wire  [7:0] data,
      output  logic req, start
              logic [1:0] mode,
              logic [7:0] addr    
    );

    always_ff @(posedge clk) begin
      ...      
    end    
  endmodule: cpucore

  //  Module: top without Interface
  module top;
    logic clk = 0;
    logic req, gnt, start, rdy;
    logic [1:0] mode;
    logic [7:0] addr;
    wire  [7:0] data;

    memory mem(.clk(clk), .req(req), .start(start), .mode(mode), .addr(addr),
              .data(data),
              .gnt(gnt), .rdy(rdy)
              );

    cpucpore cpu( .clk(clk), .gnt(gnt), .rdy(rdy), 
                  .data(data),
                  .req(req), .start(start), .mode(mode), .addr(addr) 
                );
  endmodule: top

/* Example 2: Modules memory, cpucore and top with interface */  

  // interface must be declared in a separate file and compiled separately
  interface if_bus;
    logic req, gnt, start, rdy;
    logic [1:0] mode;
    logic [7:0] addr;
    wire  [7:0] data;
  endinterface //if_bus

  //  Module: memory with Interface
  module memory
    (
      input logic clk,
      if_bus      bus   // interface port has no direction specified    
    );

    logic read, write;

    assign read = (bus.gnt && (bus.mode == 0) );
    assign write = (bus.gnt && (bus.mode == 1) );

    always_ff @(posedge clk) begin: mem_rd_wr
      if( write )
        mem[bus.addr] = bus.data;             // accessing members addr and data of the interface instance

      assign bus.data = read ? mem[addr]: 'z; // accessing members addr and data of the interface instance
    end: mem_rd_wr
  endmodule: memory

  //  Module: cpucore with Interface
  module cpucore
    (
      input logic clk,
      if_bus      bus   // interface port has no direction specified    
    );

    always_ff @(posedge clk) begin
      ...      
    end    
  endmodule: cpucore

  //  Module: top with Interface
  module top;
    logic   clk = 0;
    if_bus  bus();    // interface instance to connect module instances with such interface port

    memory mem(.clk(clk), 
              .bus(bus) 
              );

    cpucpore cpu( .clk(clk),
                  .bus(bus)
                );

    always_comb begin
      if( bus.mode == 0 ) // accessing members addr and data of the interface instance
        ...    
    end
  endmodule: top

/* Example 3: Modules memory, cpucore and top with an interface such that interface has its own port */
  
  // interface must be declared in a separate file and compiled separately
  interface if_bus( input clk); // interface now has a port signal named clk
    logic req, gnt, start, rdy;
    logic [1:0] mode;
    logic [7:0] addr;
    wire  [7:0] data;  
  endinterface //interfacename

  //  Module: memory with Interface
  module memory
    (
      if_bus bus
    );

    logic read, write;

    assign read = (bus.gnt && (bus.mode == 0) );
    assign write = (bus.gnt && (bus.mode == 1) );

    always_ff @(posedge bus.clk) begin: mem_rd_wr
      if( write )
        mem[bus.addr] = bus.data;

      assign bus.data = read ? mem[addr]: 'z;
    end: mem_rd_wr
  endmodule: memory

  //  Module: cpucore with Interface
  module cpucore
    (
      if_bus bus   // interface port has no direction specified    
    );

    // clk signal which is now part signal of the interface 
    // is now accessed as a member of the interface instance
    always_ff @(posedge bus.clk) begin
      ...      
    end    
  endmodule: cpucore

  //  Module: top with Interface
  module top;
    logic   clk = 0;
    if_bus  bus(clk);    // interface instance now has a clk signal as port argument

    memory mem(.bus(bus));
    cpucpore cpu(.bus(bus));

    always_comb begin
      if( bus.mode == 0 )
        ...    
    end
  endmodule: top

/* Example 4: Interface with port and parameters */
  interface if_fancy_bus(input clk) // interface with port
    #(
      DW = 16, AW = 8   // parameters for an interface
    )(
      input clk
    );

    logic [DW-1:0] data;
    logic [AW-1:0] addr;
    ...    
  endinterface: if_fancy_bus
  
  interface if_novel_bus    // interface with no port
    parameter DW = 16;      // parameters for an interface
    logic [D-1:0] = x, y;
    ...  
    
  endinterface: if_novel_bus
  
  module top;
    if_fancy_bus #(.DW(32), .AW(4)))  fbus1(clk); // pasing interface parameter values during module instantiation
    if_novel_bus #(.DW(64))           nbus1();
  endmodule


/* Example 5: Interface with defined modports used to define ports of modules during module definition */
  
  // interface must be declared in a separate file and compiled separately
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

  endinterface //interfacename

  //  Module: memory with Interface
  module memory
    (
      if_bus.slave bus   // module port is now of type slave sub-type view of the interface type if_bus
    );

    logic read, write;

    assign read = (bus.gnt && (bus.mode == 0) );
    assign write = (bus.gnt && (bus.mode == 1) );

    always_ff @(posedge bus.clk) begin: mem_rd_wr
      if( write )
        mem[bus.addr] = bus.data;

      assign bus.data = read ? mem[addr]: 'z;
    end: mem_rd_wr
  endmodule: memory

  //  Module: cpucore with Interface
  module cpucore
    (
      if_bus.master bus   // module port is now of sub-type master view of the interface type if_bus
    );

    always_ff @(posedge bus.clk) begin
      ...      
    end    
  endmodule: cpucore

  //  Module: top with Interface
  module top;
    logic   clk = 0;
    if_bus  bus(clk);    

    // module instances connected with interface of type if_bus
    memory mem(.bus(bus));
    cpucpore cpu(.bus(bus));

    always_comb begin
      if( bus.mode == 0 )
        ...    
    end
  endmodule: top  


/* Example 6: Interface definining Modports with Modport selection during module instantiation */
  
  // interface must be declared in a separate file and compiled separately
  interface if_bus( input clk );
    logic req, gnt, start, rdy;
    logic [1:0] mode;
    logic [7:0] addr;
    wire  [7:0] data;

    modport slave(
      input  logic req, start,
             logic [1:0] mode,
             logic [7:0] addr,
      inout  wire [7:0] data,
      output logic gnt, rdy );

    modport master(
      input   logic gnt, rdy,
      inout   wire  [7:0] data,
      output  logic req, start
              logic [1:0] mode,
              logic [7:0] addr );    

  endinterface //interfacename

  //  Module: memory with Interface
  module memory
    (
      if_bus bus   // module port is now of type interface instead of interface subtype master or slave view
    );

    reg [31:0] mem [0:31];
    logic read, write;

    assign read = (bus.gnt && (bus.mode == 0) );
    assign write = (bus.gnt && (bus.mode == 1) );

    // clk signal which is now part signal of the interface 
    // is now accessed as a member of the interface instance    
    always_ff @(posedge bus.clk) begin: mem_rd_wr
      if( write )
        mem[bus.addr] = bus.data;

      assign bus.data = read ? mem[addr]: 'z;
    end: mem_rd_wr
  endmodule: memory

  //  Module: cpucore with Interface
  module cpucore
    (
      if_bus bus   // no master or slave view defined
    );

    always_ff @(posedge bus.clk) begin
      ...      
    end    
  endmodule: cpucore

  //  Module: top with Interface
  module top;
    logic   clk = 0;
    if_bus  bus(clk);    

    memory mem(.bus(bus.slave));        // modport view selected during module instantation
    cpucpore cpu(.bus(bus.master));     // modport view selected during module instantation

    always_comb begin
      if( bus.mode == 0 )
        ...    
    end
  endmodule: top

/* Example 7: Using Interface methods aka tasks within Interface to read/write interface signals */

  // interface must be declared in a separate file and compiled separately  
  interface if_bus( input clk );
    logic req, gnt, start, rdy;
    logic [1:0] mode;
    logic [7:0] addr;
    wire  [7:0] data;
    
    modport slave(
      input  logic req, start,
             logic [1:0] mode,
             logic [7:0] addr,
      inout  wire [7:0] data,
      output logic gnt, rdy );

    modport master(
      input   logic gnt, rdy,
      inout   wire  [7:0] data,
      output  logic req, start
              logic [1:0] mode,
              logic [7:0] addr
              import read         // the interface methods must be imported in modport to make them visible
              import write );     // the interface methods must be imported in modport to make them visible

    // Interface Method read: task within the interface shared by modules which use this interface
    task read(input taddress, output tdata);
      @(posedge clk);
      addr = taddress;
      ....
      tdata = data;
    endtask: read

    // Interface Method write: task within the interface shared by modules which use this interface
    task write(input taddress, input tdata);
      @(posedge clk);
      addr = address;
      ...

      data = tdata;
    endtask: write              
  endinterface //interfacename

  //  Module: cpucore with Interface
  module cpucore
    (
      if_bus bus
    );

    ...
    // Accessing interface methods from within a module
    bus.read(addr, data);
    ...
    bus.write(addr,data);
    ...
  endmodule: cpucore

  /* Example 8: Generic Interfaces */

  //  Module: cpucore
  module cpucore( interface bus);  // port is of generic interface reference instead of a specific interface type. Actual interface type bound during instantiation
    ...
  endmodule: cpucore

  
  //  Module: memory
  module memory( interface bus);  // port is of generic interface reference instead of a specific interface type. Actual interface type bound during instantiation
    ...
  endmodule: memory

  //  Module: top with Interface
  module top;
    logic   clk = 0;
    if_bus  busx(clk);  // a specific interface type

    ...
    
    if_bus busx(clk);  // bus object of specific interface type

    memory mem(.bus(busx));   // named-port connection syntax to bind specific interface type to generic interface reference
    cpucore cpu(.bus(busx));  // named-port connection syntax to bind specific interface type to generic interface reference
      
  endmodule: top  