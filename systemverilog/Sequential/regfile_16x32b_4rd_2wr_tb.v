`timescale 1ns / 1ps

module regfile_16x32b_4rd_2wr_tb;

  // Inputs
  reg clk;
  reg rst;
  reg [3:0] rdport1_ctrl_add;
  reg [3:0] rdport2_ctrl_add;
  reg [3:0] rdport3_ctrl_add;
  reg [3:0] rdport4_ctrl_add;
  reg [3:0] wrport1_ctrl_add;
  reg [31:0] wrport1_data_in;
  reg wrport1_wren;
  reg [3:0] wrport2_ctrl_add;
  reg [31:0] wrport2_data_in;
  reg wrport2_wren;

  // Outputs
  wire [31:0] rdport1_data_out;
  wire [31:0] rdport2_data_out;
  wire [31:0] rdport3_data_out;
  wire [31:0] rdport4_data_out;

  // Variables
  integer i = 0;

  // Instantiate the Unit Under Test (UUT)
  regfile_16x32b_4rd_2wr uut (
  .clk(clk),
  .rst(rst),
  .rdport1_ctrl_add(rdport1_ctrl_add),
  .rdport1_data_out(rdport1_data_out),
  .rdport2_ctrl_add(rdport2_ctrl_add),
  .rdport2_data_out(rdport2_data_out),
  .rdport3_ctrl_add(rdport3_ctrl_add),
  .rdport3_data_out(rdport3_data_out),
  .rdport4_ctrl_add(rdport4_ctrl_add),
  .rdport4_data_out(rdport4_data_out),
  .wrport1_ctrl_add(wrport1_ctrl_add),
  .wrport1_data_in(wrport1_data_in),
  .wrport1_wren(wrport1_wren),
  .wrport2_ctrl_add(wrport2_ctrl_add),
  .wrport2_data_in(wrport2_data_in),
  .wrport2_wren(wrport2_wren)
  );

  task expectRead;
    input [31:0] exp_out0;
    input [31:0] exp_out1;
    input [31:0] exp_out2;
    input [31:0] exp_out3;
    if ((rdport1_data_out !== exp_out0) || (rdport2_data_out !== exp_out1) || (rdport3_data_out !== exp_out2) || (rdport4_data_out !== exp_out3)) begin
      $display("TEST FAILED");
      $display("At time %0d rdport1_ctrl_add=%0d, rdport1_data_out=%0d, rdport2_ctrl_add=%0d, rdport2_data_out=%0d, rdport3_ctrl_add=%0d, rdport3_data_out=%0d, rdport4_ctrl_add=%0d, rdport4_data_out=%0d ",
               $time,
               rdport1_ctrl_add, rdport1_data_out,
               rdport2_ctrl_add, rdport2_data_out,
               rdport3_ctrl_add, rdport3_data_out,
               rdport4_ctrl_add, rdport4_data_out);

      $display("rdport1_data_out, rdport2_data_out, rdport3_data_out, rdport4_data_out should be %0d, %0d, %0d, %0d",
                exp_out0, exp_out1, exp_out2, exp_out3 );
      $finish;
    end
   else begin
      $display("At time %0d rdport1_ctrl_add=%0d, rdport1_data_out=%0d, rdport2_ctrl_add=%0d, rdport2_data_out=%0d, rdport3_ctrl_add=%0d, rdport3_data_out=%0d, rdport4_ctrl_add=%0d, rdport4_data_out=%0d ",
               $time,
               rdport1_ctrl_add, rdport1_data_out,
               rdport2_ctrl_add, rdport2_data_out,
               rdport3_ctrl_add, rdport3_data_out,
               rdport4_ctrl_add, rdport4_data_out);
   end
  endtask

  // Clock and sync reset stimulus
  initial begin
   clk = 1'b0;
   rst = 1'b1;

   // hold sync reset for next 2 cc
   repeat(4) #10 clk = ~clk;

   // deassert reset
   rst  = 1'b0;

   // clock forever
   forever #10 clk = ~clk;
  end

  // Stimulus
  initial begin
    // Initialize Inputs
    rdport1_ctrl_add = 0;
    rdport2_ctrl_add = 0;
    rdport3_ctrl_add = 0;
    rdport4_ctrl_add = 0;
    wrport1_ctrl_add = 0;
    wrport1_data_in = 0;
    wrport1_wren = 0;
    wrport2_ctrl_add = 0;
    wrport2_data_in = 0;
    wrport2_wren = 0;

    // wait for reset to deassert
    @(negedge rst);

    // write to first 8 registers using port 1 and last 8 registers using port 2
    // write values 16x1, 16x2, 16x3..16x8 by wr port 1 to the first 8 registers
    // write values 16x9, 16x10, 16x11..16x16 by wr port 2 to the next 8 registers
    for( i = 0; i < 8 ; i = i+1)
    begin
      wrport1_ctrl_add = i;
      wrport1_data_in = (i+1)*16;
      wrport2_ctrl_add = i + 8;
      wrport2_data_in = (i+9)*16;
      wrport1_wren = 1;
      wrport2_wren = 1;

      // wait for negative clock edge
      @(negedge clk);
    end

    // Deassert write enables
    wrport1_wren = 0;
    wrport2_wren = 0;

    // Read back all 16 registers using 4 read ports
    // with per port reading 4 registers
    // RDP1(R0-R3), RDP2(R4-R7), RDP3(R8-R11), RDP4(R12-R15)
    for( i = 0; i < 4 ; i = i+1)
    begin
      rdport1_ctrl_add = i;
      rdport2_ctrl_add = i+4;
      rdport3_ctrl_add = i+8;
      rdport4_ctrl_add = i+12;

      // wait for negative clock edge
      @(negedge clk);
      expectRead( 16*(i+1), 16*(i+5), 16*(i+9), 16*(i+13));
    end

    // Test write collision: write to same register
    // simulataneously from two write ports with different values.
    // only write by first write port should go through while
    // the write by second port should be ignored
    wrport1_ctrl_add = 10;
    wrport1_data_in = 100;
    wrport2_ctrl_add =10;
    wrport2_data_in = 1000;
    wrport1_wren = 1;
    wrport2_wren = 1;

    // wait for negative clock edge
    @(negedge clk);

    wrport1_wren = 0;
    wrport2_wren = 0;

    // read same register using all 4 read ports
    // to check which of the two collision writes
    // went through. this also verifies if we can
    // simulataneously read from same register using
    // all 4 ports
    rdport1_ctrl_add = 10;
    rdport2_ctrl_add = 10;
    rdport3_ctrl_add = 10;
    rdport4_ctrl_add = 10;
    @(negedge clk);
    expectRead( 100, 100, 100, 100);

    $display("TEST PASSED");
    $finish;
  end
endmodule
