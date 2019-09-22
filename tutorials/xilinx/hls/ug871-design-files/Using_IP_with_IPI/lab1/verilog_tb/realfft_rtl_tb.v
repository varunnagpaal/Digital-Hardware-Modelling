/*******************************************************************************
Vendor: Xilinx
Associated Filename: realfft_rtl_tb.v
Purpose: Part of a Vivado HLS tutorial example
Device: All
Revision History: March 31, 2013 - initial release

*******************************************************************************
Copyright (C) 2013 XILINX, Inc.

This file contains confidential and proprietary information of Xilinx, Inc. and
is protected under U.S. and international copyright and other intellectual
property laws.

DISCLAIMER
This disclaimer is not a license and does not grant any rights to the materials
distributed herewith. Except as otherwise provided in a valid license issued to
you by Xilinx, and to the maximum extent permitted by applicable law:
(1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS, AND XILINX
HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY,
INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, OR
FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx shall not be liable (whether
in contract or tort, including negligence, or under any other theory of
liability) for any loss or damage of any kind or nature related to, arising under
or in connection with these materials, including for any direct, or any indirect,
special, incidental, or consequential loss or damage (including loss of data,
profits, goodwill, or any type of loss or damage suffered as a result of any
action brought by a third party) even if such damage or loss was reasonably
foreseeable or Xilinx had been advised of the possibility of the same.

CRITICAL APPLICATIONS
Xilinx products are not designed or intended to be fail-safe, or for use in any
application requiring fail-safe performance, such as life-support or safety
devices or systems, Class III medical devices, nuclear facilities, applications
related to the deployment of airbags, or any other applications that could lead
to death, personal injury, or severe property or environmental damage
(individually and collectively, "Critical Applications"). Customer asresultes the
sole risk and liability of any use of Xilinx products in Critical Applications,
subject only to applicable laws and regulations governing limitations on product
liability.

THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT
ALL TIMES.

*******************************************************************************/

`timescale 1 ns / 1 ps

`define EOF 32'hFFFF_FFFF
`define NULL 0
`define MAX_LINE_LENGTH 1000

module realfft_rtl_tb ();

reg aclk = 1'b0;
reg aresetn = 1'b1;

reg [15:0]real2xfft_din_tdata;
wire real2xfft_din_tready;
reg real2xfft_din_tvalid;
wire [31:0]xfft2real_dout_tdata;
reg xfft2real_dout_tready;
wire xfft2real_dout_tvalid;

//RealFFT_wrapper dut0 (
RealFFT_wrapper dut0 (
   .aclk(aclk),
   .aresetn(aresetn),
   .real2xfft_din_tdata(real2xfft_din_tdata),
   .real2xfft_din_tready(real2xfft_din_tready),
   .real2xfft_din_tvalid(real2xfft_din_tvalid),
   .xfft2real_dout_tdata(xfft2real_dout_tdata),
   .xfft2real_dout_tready(xfft2real_dout_tready),
   .xfft2real_dout_tvalid(xfft2real_dout_tvalid)
);
// Clock generator
always #5 aclk = ~aclk;

// Reset generator
initial begin
   #10
   @(posedge aclk)
   aresetn = 1'b0;
   #100
   @(posedge aclk)
   aresetn = 1'b1;
end

// real2fft stimulus process
initial begin : tvin_block
   integer tvin_fd, c, r, i;
   reg [8*`MAX_LINE_LENGTH:0] line; /* Line of text read from file */
   reg [31:0] num_sent;
   tvin_fd = $fopen("../../../../verilog_tb/realfft_fe_tvin.dat", "r");
   if (tvin_fd == `NULL) begin// If error opening file
      $display("Could not open input test vector file. Bailing out...");
      disable tvin_block; // Just quit
   end

   // Wait for areset to assert and de-assert
   wait(aresetn == 1'b0) @(posedge aclk);
   num_sent = 0;
   real2xfft_din_tdata = 32'hDEADBEEF;
   real2xfft_din_tvalid = 1'b0;
   wait(aresetn == 1'b1) @(posedge aclk);
   #20
   @(negedge aclk)
   // Read entire input TV file
   c = $fgetc(tvin_fd);
   while (c != `EOF) begin
      /* Check the first character for comment */
      if (c == "/")
         r = $fgets(line, tvin_fd);
      else begin
         // Push the character back to the tvin_fd then read the next TV
         r = $ungetc(c, tvin_fd);
         r = $fscanf(tvin_fd," %h\n", real2xfft_din_tdata);
         real2xfft_din_tvalid = 1'b1;
         // Hold AXIS output signals until TREADY is asserted
         wait(real2xfft_din_tready == 1'b1) @(negedge aclk)
         num_sent = num_sent + 1;
      end // if c else
      c = $fgetc(tvin_fd);
   end // while not EOF
   // Flush the FFT pipeline
   for (i = 0; i < 1024; i = i + 1) begin
      real2xfft_din_tdata = 32'h0000_0000;
      real2xfft_din_tvalid = 1'b1;
      // Hold AXIS output signals until TREADY is asserted
      wait(real2xfft_din_tready == 1'b1) @(negedge aclk)
      num_sent = num_sent + 1;
   end
   real2xfft_din_tdata = 32'hCAFEDECA;
   real2xfft_din_tvalid = 1'b0;

   $fclose(tvin_fd);
end // initial

// xfft2real response process
initial begin : tvout_block
   integer tvout_fd, c, r;
   reg [8*`MAX_LINE_LENGTH:0] line; /* Line of text read from file */
   reg [31:0] tvout_expected;
   reg [31:0] num_rx;
   integer err_cnt;
   tvout_fd = $fopen("../../../../verilog_tb/realfft_be_tvout.dat", "r");
   if (tvout_fd == `NULL) begin // If error opening file
      $display("Could not open output test vector file. Bailing out...");
      disable tvout_block; // Just quit
   end

   // Wait for areset to assert and de-assert
   wait(aresetn == 1'b0) @(posedge aclk);
   err_cnt = 0;
   num_rx = 0;
   xfft2real_dout_tready = 1'b0;
   wait(aresetn == 1'b1) @(posedge aclk);
   #20
   @(negedge aclk)
   // Set TREADY - never de-asserted until all responses received
   xfft2real_dout_tready = 1'b1;

   // Read entire output TV file and compare against golden data
   c = $fgetc(tvout_fd);
   while (c != `EOF) begin
      /* Check the first character for comment */
      if (c == "/")
         r = $fgets(line, tvout_fd);
      else begin
         // Push the character back to the tvout_fd then read the next TV
         r = $ungetc(c, tvout_fd);
         r = $fscanf(tvout_fd," %h\n", tvout_expected);
         @(negedge aclk)
         // Wait for TVALID
         while(xfft2real_dout_tvalid == 1'b0) begin
            @(negedge aclk);
         end
         // TODO: Check tvout_val against expected data accounting for
         // precision losses...
         $display("%d - Expected: 0x%8h; Got: 0x%8h", num_rx[8:0], tvout_expected, xfft2real_dout_tdata);
         $display("Expect differences of less than 2-3 bits due to rounding");
         num_rx = num_rx + 1;
      end // if c else
      c = $fgetc(tvout_fd);
   end // while not EOF
   //xfft2real_dout_tready = 1'b0;
   #200

   $fclose(tvout_fd);
   $finish;
end // initial

endmodule

