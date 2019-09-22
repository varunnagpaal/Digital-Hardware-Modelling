// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sun Sep 22 03:32:36 2019
// Host        : varun-laptop running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ gcd_block_design_gcd_0_1_stub.v
// Design      : gcd_block_design_gcd_0_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "gcd,Vivado 2018.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(s_axi_gcd_bus_AWADDR, 
  s_axi_gcd_bus_AWVALID, s_axi_gcd_bus_AWREADY, s_axi_gcd_bus_WDATA, s_axi_gcd_bus_WSTRB, 
  s_axi_gcd_bus_WVALID, s_axi_gcd_bus_WREADY, s_axi_gcd_bus_BRESP, s_axi_gcd_bus_BVALID, 
  s_axi_gcd_bus_BREADY, s_axi_gcd_bus_ARADDR, s_axi_gcd_bus_ARVALID, 
  s_axi_gcd_bus_ARREADY, s_axi_gcd_bus_RDATA, s_axi_gcd_bus_RRESP, s_axi_gcd_bus_RVALID, 
  s_axi_gcd_bus_RREADY, ap_clk, ap_rst_n, interrupt)
/* synthesis syn_black_box black_box_pad_pin="s_axi_gcd_bus_AWADDR[5:0],s_axi_gcd_bus_AWVALID,s_axi_gcd_bus_AWREADY,s_axi_gcd_bus_WDATA[31:0],s_axi_gcd_bus_WSTRB[3:0],s_axi_gcd_bus_WVALID,s_axi_gcd_bus_WREADY,s_axi_gcd_bus_BRESP[1:0],s_axi_gcd_bus_BVALID,s_axi_gcd_bus_BREADY,s_axi_gcd_bus_ARADDR[5:0],s_axi_gcd_bus_ARVALID,s_axi_gcd_bus_ARREADY,s_axi_gcd_bus_RDATA[31:0],s_axi_gcd_bus_RRESP[1:0],s_axi_gcd_bus_RVALID,s_axi_gcd_bus_RREADY,ap_clk,ap_rst_n,interrupt" */;
  input [5:0]s_axi_gcd_bus_AWADDR;
  input s_axi_gcd_bus_AWVALID;
  output s_axi_gcd_bus_AWREADY;
  input [31:0]s_axi_gcd_bus_WDATA;
  input [3:0]s_axi_gcd_bus_WSTRB;
  input s_axi_gcd_bus_WVALID;
  output s_axi_gcd_bus_WREADY;
  output [1:0]s_axi_gcd_bus_BRESP;
  output s_axi_gcd_bus_BVALID;
  input s_axi_gcd_bus_BREADY;
  input [5:0]s_axi_gcd_bus_ARADDR;
  input s_axi_gcd_bus_ARVALID;
  output s_axi_gcd_bus_ARREADY;
  output [31:0]s_axi_gcd_bus_RDATA;
  output [1:0]s_axi_gcd_bus_RRESP;
  output s_axi_gcd_bus_RVALID;
  input s_axi_gcd_bus_RREADY;
  input ap_clk;
  input ap_rst_n;
  output interrupt;
endmodule
