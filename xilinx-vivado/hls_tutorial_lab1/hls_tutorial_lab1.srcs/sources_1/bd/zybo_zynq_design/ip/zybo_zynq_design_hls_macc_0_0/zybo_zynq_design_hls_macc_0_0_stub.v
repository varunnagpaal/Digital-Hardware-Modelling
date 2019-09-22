// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sun Sep 22 02:34:40 2019
// Host        : varun-laptop running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               d:/github/Digital-Hardware-Modelling/xilinx-vivado/hls_tutorial_lab1/hls_tutorial_lab1.srcs/sources_1/bd/zybo_zynq_design/ip/zybo_zynq_design_hls_macc_0_0/zybo_zynq_design_hls_macc_0_0_stub.v
// Design      : zybo_zynq_design_hls_macc_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "hls_macc,Vivado 2018.2" *)
module zybo_zynq_design_hls_macc_0_0(s_axi_HLS_MACC_PERIPH_BUS_AWADDR, 
  s_axi_HLS_MACC_PERIPH_BUS_AWVALID, s_axi_HLS_MACC_PERIPH_BUS_AWREADY, 
  s_axi_HLS_MACC_PERIPH_BUS_WDATA, s_axi_HLS_MACC_PERIPH_BUS_WSTRB, 
  s_axi_HLS_MACC_PERIPH_BUS_WVALID, s_axi_HLS_MACC_PERIPH_BUS_WREADY, 
  s_axi_HLS_MACC_PERIPH_BUS_BRESP, s_axi_HLS_MACC_PERIPH_BUS_BVALID, 
  s_axi_HLS_MACC_PERIPH_BUS_BREADY, s_axi_HLS_MACC_PERIPH_BUS_ARADDR, 
  s_axi_HLS_MACC_PERIPH_BUS_ARVALID, s_axi_HLS_MACC_PERIPH_BUS_ARREADY, 
  s_axi_HLS_MACC_PERIPH_BUS_RDATA, s_axi_HLS_MACC_PERIPH_BUS_RRESP, 
  s_axi_HLS_MACC_PERIPH_BUS_RVALID, s_axi_HLS_MACC_PERIPH_BUS_RREADY, ap_clk, ap_rst_n, 
  interrupt)
/* synthesis syn_black_box black_box_pad_pin="s_axi_HLS_MACC_PERIPH_BUS_AWADDR[5:0],s_axi_HLS_MACC_PERIPH_BUS_AWVALID,s_axi_HLS_MACC_PERIPH_BUS_AWREADY,s_axi_HLS_MACC_PERIPH_BUS_WDATA[31:0],s_axi_HLS_MACC_PERIPH_BUS_WSTRB[3:0],s_axi_HLS_MACC_PERIPH_BUS_WVALID,s_axi_HLS_MACC_PERIPH_BUS_WREADY,s_axi_HLS_MACC_PERIPH_BUS_BRESP[1:0],s_axi_HLS_MACC_PERIPH_BUS_BVALID,s_axi_HLS_MACC_PERIPH_BUS_BREADY,s_axi_HLS_MACC_PERIPH_BUS_ARADDR[5:0],s_axi_HLS_MACC_PERIPH_BUS_ARVALID,s_axi_HLS_MACC_PERIPH_BUS_ARREADY,s_axi_HLS_MACC_PERIPH_BUS_RDATA[31:0],s_axi_HLS_MACC_PERIPH_BUS_RRESP[1:0],s_axi_HLS_MACC_PERIPH_BUS_RVALID,s_axi_HLS_MACC_PERIPH_BUS_RREADY,ap_clk,ap_rst_n,interrupt" */;
  input [5:0]s_axi_HLS_MACC_PERIPH_BUS_AWADDR;
  input s_axi_HLS_MACC_PERIPH_BUS_AWVALID;
  output s_axi_HLS_MACC_PERIPH_BUS_AWREADY;
  input [31:0]s_axi_HLS_MACC_PERIPH_BUS_WDATA;
  input [3:0]s_axi_HLS_MACC_PERIPH_BUS_WSTRB;
  input s_axi_HLS_MACC_PERIPH_BUS_WVALID;
  output s_axi_HLS_MACC_PERIPH_BUS_WREADY;
  output [1:0]s_axi_HLS_MACC_PERIPH_BUS_BRESP;
  output s_axi_HLS_MACC_PERIPH_BUS_BVALID;
  input s_axi_HLS_MACC_PERIPH_BUS_BREADY;
  input [5:0]s_axi_HLS_MACC_PERIPH_BUS_ARADDR;
  input s_axi_HLS_MACC_PERIPH_BUS_ARVALID;
  output s_axi_HLS_MACC_PERIPH_BUS_ARREADY;
  output [31:0]s_axi_HLS_MACC_PERIPH_BUS_RDATA;
  output [1:0]s_axi_HLS_MACC_PERIPH_BUS_RRESP;
  output s_axi_HLS_MACC_PERIPH_BUS_RVALID;
  input s_axi_HLS_MACC_PERIPH_BUS_RREADY;
  input ap_clk;
  input ap_rst_n;
  output interrupt;
endmodule
