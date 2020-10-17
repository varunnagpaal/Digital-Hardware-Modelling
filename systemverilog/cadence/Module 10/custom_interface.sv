//  Interface: custom_interface
interface custom_interface
  (
    logic clk,
    logic rst
  );

  logic as, rw, ds, da;
  logic [15:0]  data;
  logic [7:0]   addr;

  modport busreader(
    input   logic da,
            logic [15:0] data,
    output  logic as, rw, ds,
            logic [7:0] addr
  );
  modport busmanager(
    output  logic da,
            logic [15:0] data,
    input   logic as, rw, ds,
            logic [7:0] addr
  );
  
endinterface: custom_interface