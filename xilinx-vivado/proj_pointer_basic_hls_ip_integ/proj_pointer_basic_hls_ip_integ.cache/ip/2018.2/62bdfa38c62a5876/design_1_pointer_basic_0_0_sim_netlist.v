// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Mon Sep 16 04:56:42 2019
// Host        : varun-laptop running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_pointer_basic_0_0_sim_netlist.v
// Design      : design_1_pointer_basic_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_pointer_basic_0_0,pointer_basic,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "HLS" *) 
(* X_CORE_INFO = "pointer_basic,Vivado 2018.2" *) (* hls_module = "yes" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (s_axi_pointer_basic_io_AWADDR,
    s_axi_pointer_basic_io_AWVALID,
    s_axi_pointer_basic_io_AWREADY,
    s_axi_pointer_basic_io_WDATA,
    s_axi_pointer_basic_io_WSTRB,
    s_axi_pointer_basic_io_WVALID,
    s_axi_pointer_basic_io_WREADY,
    s_axi_pointer_basic_io_BRESP,
    s_axi_pointer_basic_io_BVALID,
    s_axi_pointer_basic_io_BREADY,
    s_axi_pointer_basic_io_ARADDR,
    s_axi_pointer_basic_io_ARVALID,
    s_axi_pointer_basic_io_ARREADY,
    s_axi_pointer_basic_io_RDATA,
    s_axi_pointer_basic_io_RRESP,
    s_axi_pointer_basic_io_RVALID,
    s_axi_pointer_basic_io_RREADY,
    ap_clk,
    ap_rst_n,
    ap_start,
    ap_done,
    ap_idle,
    ap_ready);
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io AWADDR" *) input [4:0]s_axi_pointer_basic_io_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io AWVALID" *) input s_axi_pointer_basic_io_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io AWREADY" *) output s_axi_pointer_basic_io_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io WDATA" *) input [31:0]s_axi_pointer_basic_io_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io WSTRB" *) input [3:0]s_axi_pointer_basic_io_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io WVALID" *) input s_axi_pointer_basic_io_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io WREADY" *) output s_axi_pointer_basic_io_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io BRESP" *) output [1:0]s_axi_pointer_basic_io_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io BVALID" *) output s_axi_pointer_basic_io_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io BREADY" *) input s_axi_pointer_basic_io_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io ARADDR" *) input [4:0]s_axi_pointer_basic_io_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io ARVALID" *) input s_axi_pointer_basic_io_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io ARREADY" *) output s_axi_pointer_basic_io_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io RDATA" *) output [31:0]s_axi_pointer_basic_io_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io RRESP" *) output [1:0]s_axi_pointer_basic_io_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io RVALID" *) output s_axi_pointer_basic_io_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_pointer_basic_io RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_pointer_basic_io, ADDR_WIDTH 5, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {CLK {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}, FREQ_HZ 50000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 4, NUM_WRITE_THREADS 4, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0" *) input s_axi_pointer_basic_io_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF s_axi_pointer_basic_io, ASSOCIATED_RESET ap_rst_n, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {CLK {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}, FREQ_HZ 50000000, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0" *) input ap_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {RST {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}" *) input ap_rst_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl start" *) input ap_start;
  (* X_INTERFACE_INFO = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl done" *) output ap_done;
  (* X_INTERFACE_INFO = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl idle" *) output ap_idle;
  (* X_INTERFACE_INFO = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl ready" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_ctrl, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {start {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}} done {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}} idle {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}} ready {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}" *) output ap_ready;

  wire ap_clk;
  wire ap_done;
  wire ap_idle;
  wire ap_ready;
  wire ap_rst_n;
  wire ap_start;
  wire [4:0]s_axi_pointer_basic_io_ARADDR;
  wire s_axi_pointer_basic_io_ARREADY;
  wire s_axi_pointer_basic_io_ARVALID;
  wire [4:0]s_axi_pointer_basic_io_AWADDR;
  wire s_axi_pointer_basic_io_AWREADY;
  wire s_axi_pointer_basic_io_AWVALID;
  wire s_axi_pointer_basic_io_BREADY;
  wire [1:0]s_axi_pointer_basic_io_BRESP;
  wire s_axi_pointer_basic_io_BVALID;
  wire [31:0]s_axi_pointer_basic_io_RDATA;
  wire s_axi_pointer_basic_io_RREADY;
  wire [1:0]s_axi_pointer_basic_io_RRESP;
  wire s_axi_pointer_basic_io_RVALID;
  wire [31:0]s_axi_pointer_basic_io_WDATA;
  wire s_axi_pointer_basic_io_WREADY;
  wire [3:0]s_axi_pointer_basic_io_WSTRB;
  wire s_axi_pointer_basic_io_WVALID;

  (* C_S_AXI_DATA_WIDTH = "32" *) 
  (* C_S_AXI_POINTER_BASIC_IO_ADDR_WIDTH = "5" *) 
  (* C_S_AXI_POINTER_BASIC_IO_DATA_WIDTH = "32" *) 
  (* C_S_AXI_POINTER_BASIC_IO_WSTRB_WIDTH = "4" *) 
  (* C_S_AXI_WSTRB_WIDTH = "4" *) 
  (* ap_ST_fsm_state1 = "3'b001" *) 
  (* ap_ST_fsm_state2 = "3'b010" *) 
  (* ap_ST_fsm_state3 = "3'b100" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_pointer_basic inst
       (.ap_clk(ap_clk),
        .ap_done(ap_done),
        .ap_idle(ap_idle),
        .ap_ready(ap_ready),
        .ap_rst_n(ap_rst_n),
        .ap_start(ap_start),
        .s_axi_pointer_basic_io_ARADDR(s_axi_pointer_basic_io_ARADDR),
        .s_axi_pointer_basic_io_ARREADY(s_axi_pointer_basic_io_ARREADY),
        .s_axi_pointer_basic_io_ARVALID(s_axi_pointer_basic_io_ARVALID),
        .s_axi_pointer_basic_io_AWADDR(s_axi_pointer_basic_io_AWADDR),
        .s_axi_pointer_basic_io_AWREADY(s_axi_pointer_basic_io_AWREADY),
        .s_axi_pointer_basic_io_AWVALID(s_axi_pointer_basic_io_AWVALID),
        .s_axi_pointer_basic_io_BREADY(s_axi_pointer_basic_io_BREADY),
        .s_axi_pointer_basic_io_BRESP(s_axi_pointer_basic_io_BRESP),
        .s_axi_pointer_basic_io_BVALID(s_axi_pointer_basic_io_BVALID),
        .s_axi_pointer_basic_io_RDATA(s_axi_pointer_basic_io_RDATA),
        .s_axi_pointer_basic_io_RREADY(s_axi_pointer_basic_io_RREADY),
        .s_axi_pointer_basic_io_RRESP(s_axi_pointer_basic_io_RRESP),
        .s_axi_pointer_basic_io_RVALID(s_axi_pointer_basic_io_RVALID),
        .s_axi_pointer_basic_io_WDATA(s_axi_pointer_basic_io_WDATA),
        .s_axi_pointer_basic_io_WREADY(s_axi_pointer_basic_io_WREADY),
        .s_axi_pointer_basic_io_WSTRB(s_axi_pointer_basic_io_WSTRB),
        .s_axi_pointer_basic_io_WVALID(s_axi_pointer_basic_io_WVALID));
endmodule

(* C_S_AXI_DATA_WIDTH = "32" *) (* C_S_AXI_POINTER_BASIC_IO_ADDR_WIDTH = "5" *) (* C_S_AXI_POINTER_BASIC_IO_DATA_WIDTH = "32" *) 
(* C_S_AXI_POINTER_BASIC_IO_WSTRB_WIDTH = "4" *) (* C_S_AXI_WSTRB_WIDTH = "4" *) (* ap_ST_fsm_state1 = "3'b001" *) 
(* ap_ST_fsm_state2 = "3'b010" *) (* ap_ST_fsm_state3 = "3'b100" *) (* hls_module = "yes" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_pointer_basic
   (ap_clk,
    ap_rst_n,
    ap_start,
    ap_done,
    ap_idle,
    ap_ready,
    s_axi_pointer_basic_io_AWVALID,
    s_axi_pointer_basic_io_AWREADY,
    s_axi_pointer_basic_io_AWADDR,
    s_axi_pointer_basic_io_WVALID,
    s_axi_pointer_basic_io_WREADY,
    s_axi_pointer_basic_io_WDATA,
    s_axi_pointer_basic_io_WSTRB,
    s_axi_pointer_basic_io_ARVALID,
    s_axi_pointer_basic_io_ARREADY,
    s_axi_pointer_basic_io_ARADDR,
    s_axi_pointer_basic_io_RVALID,
    s_axi_pointer_basic_io_RREADY,
    s_axi_pointer_basic_io_RDATA,
    s_axi_pointer_basic_io_RRESP,
    s_axi_pointer_basic_io_BVALID,
    s_axi_pointer_basic_io_BREADY,
    s_axi_pointer_basic_io_BRESP);
  input ap_clk;
  input ap_rst_n;
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  input s_axi_pointer_basic_io_AWVALID;
  output s_axi_pointer_basic_io_AWREADY;
  input [4:0]s_axi_pointer_basic_io_AWADDR;
  input s_axi_pointer_basic_io_WVALID;
  output s_axi_pointer_basic_io_WREADY;
  input [31:0]s_axi_pointer_basic_io_WDATA;
  input [3:0]s_axi_pointer_basic_io_WSTRB;
  input s_axi_pointer_basic_io_ARVALID;
  output s_axi_pointer_basic_io_ARREADY;
  input [4:0]s_axi_pointer_basic_io_ARADDR;
  output s_axi_pointer_basic_io_RVALID;
  input s_axi_pointer_basic_io_RREADY;
  output [31:0]s_axi_pointer_basic_io_RDATA;
  output [1:0]s_axi_pointer_basic_io_RRESP;
  output s_axi_pointer_basic_io_BVALID;
  input s_axi_pointer_basic_io_BREADY;
  output [1:0]s_axi_pointer_basic_io_BRESP;

  wire \<const0> ;
  wire \acc[0]_i_2_n_0 ;
  wire \acc[0]_i_3_n_0 ;
  wire \acc[0]_i_4_n_0 ;
  wire \acc[0]_i_5_n_0 ;
  wire \acc[12]_i_2_n_0 ;
  wire \acc[12]_i_3_n_0 ;
  wire \acc[12]_i_4_n_0 ;
  wire \acc[12]_i_5_n_0 ;
  wire \acc[16]_i_2_n_0 ;
  wire \acc[16]_i_3_n_0 ;
  wire \acc[16]_i_4_n_0 ;
  wire \acc[16]_i_5_n_0 ;
  wire \acc[20]_i_2_n_0 ;
  wire \acc[20]_i_3_n_0 ;
  wire \acc[20]_i_4_n_0 ;
  wire \acc[20]_i_5_n_0 ;
  wire \acc[24]_i_2_n_0 ;
  wire \acc[24]_i_3_n_0 ;
  wire \acc[24]_i_4_n_0 ;
  wire \acc[24]_i_5_n_0 ;
  wire \acc[28]_i_2_n_0 ;
  wire \acc[28]_i_3_n_0 ;
  wire \acc[28]_i_4_n_0 ;
  wire \acc[28]_i_5_n_0 ;
  wire \acc[4]_i_2_n_0 ;
  wire \acc[4]_i_3_n_0 ;
  wire \acc[4]_i_4_n_0 ;
  wire \acc[4]_i_5_n_0 ;
  wire \acc[8]_i_2_n_0 ;
  wire \acc[8]_i_3_n_0 ;
  wire \acc[8]_i_4_n_0 ;
  wire \acc[8]_i_5_n_0 ;
  wire [31:0]acc_reg;
  wire \acc_reg[0]_i_1_n_0 ;
  wire \acc_reg[0]_i_1_n_1 ;
  wire \acc_reg[0]_i_1_n_2 ;
  wire \acc_reg[0]_i_1_n_3 ;
  wire \acc_reg[0]_i_1_n_4 ;
  wire \acc_reg[0]_i_1_n_5 ;
  wire \acc_reg[0]_i_1_n_6 ;
  wire \acc_reg[0]_i_1_n_7 ;
  wire \acc_reg[12]_i_1_n_0 ;
  wire \acc_reg[12]_i_1_n_1 ;
  wire \acc_reg[12]_i_1_n_2 ;
  wire \acc_reg[12]_i_1_n_3 ;
  wire \acc_reg[12]_i_1_n_4 ;
  wire \acc_reg[12]_i_1_n_5 ;
  wire \acc_reg[12]_i_1_n_6 ;
  wire \acc_reg[12]_i_1_n_7 ;
  wire \acc_reg[16]_i_1_n_0 ;
  wire \acc_reg[16]_i_1_n_1 ;
  wire \acc_reg[16]_i_1_n_2 ;
  wire \acc_reg[16]_i_1_n_3 ;
  wire \acc_reg[16]_i_1_n_4 ;
  wire \acc_reg[16]_i_1_n_5 ;
  wire \acc_reg[16]_i_1_n_6 ;
  wire \acc_reg[16]_i_1_n_7 ;
  wire \acc_reg[20]_i_1_n_0 ;
  wire \acc_reg[20]_i_1_n_1 ;
  wire \acc_reg[20]_i_1_n_2 ;
  wire \acc_reg[20]_i_1_n_3 ;
  wire \acc_reg[20]_i_1_n_4 ;
  wire \acc_reg[20]_i_1_n_5 ;
  wire \acc_reg[20]_i_1_n_6 ;
  wire \acc_reg[20]_i_1_n_7 ;
  wire \acc_reg[24]_i_1_n_0 ;
  wire \acc_reg[24]_i_1_n_1 ;
  wire \acc_reg[24]_i_1_n_2 ;
  wire \acc_reg[24]_i_1_n_3 ;
  wire \acc_reg[24]_i_1_n_4 ;
  wire \acc_reg[24]_i_1_n_5 ;
  wire \acc_reg[24]_i_1_n_6 ;
  wire \acc_reg[24]_i_1_n_7 ;
  wire \acc_reg[28]_i_1_n_1 ;
  wire \acc_reg[28]_i_1_n_2 ;
  wire \acc_reg[28]_i_1_n_3 ;
  wire \acc_reg[28]_i_1_n_4 ;
  wire \acc_reg[28]_i_1_n_5 ;
  wire \acc_reg[28]_i_1_n_6 ;
  wire \acc_reg[28]_i_1_n_7 ;
  wire \acc_reg[4]_i_1_n_0 ;
  wire \acc_reg[4]_i_1_n_1 ;
  wire \acc_reg[4]_i_1_n_2 ;
  wire \acc_reg[4]_i_1_n_3 ;
  wire \acc_reg[4]_i_1_n_4 ;
  wire \acc_reg[4]_i_1_n_5 ;
  wire \acc_reg[4]_i_1_n_6 ;
  wire \acc_reg[4]_i_1_n_7 ;
  wire \acc_reg[8]_i_1_n_0 ;
  wire \acc_reg[8]_i_1_n_1 ;
  wire \acc_reg[8]_i_1_n_2 ;
  wire \acc_reg[8]_i_1_n_3 ;
  wire \acc_reg[8]_i_1_n_4 ;
  wire \acc_reg[8]_i_1_n_5 ;
  wire \acc_reg[8]_i_1_n_6 ;
  wire \acc_reg[8]_i_1_n_7 ;
  wire \ap_CS_fsm_reg_n_0_[0] ;
  wire ap_CS_fsm_state2;
  wire [1:0]ap_NS_fsm;
  wire ap_NS_fsm1;
  wire ap_clk;
  wire ap_done;
  wire ap_idle;
  wire ap_rst_n;
  wire ap_rst_n_inv;
  wire ap_start;
  wire [31:0]d_i;
  wire [31:0]d_read_reg_52;
  wire [4:0]s_axi_pointer_basic_io_ARADDR;
  wire s_axi_pointer_basic_io_ARREADY;
  wire s_axi_pointer_basic_io_ARVALID;
  wire [4:0]s_axi_pointer_basic_io_AWADDR;
  wire s_axi_pointer_basic_io_AWREADY;
  wire s_axi_pointer_basic_io_AWVALID;
  wire s_axi_pointer_basic_io_BREADY;
  wire s_axi_pointer_basic_io_BVALID;
  wire [31:0]s_axi_pointer_basic_io_RDATA;
  wire s_axi_pointer_basic_io_RREADY;
  wire s_axi_pointer_basic_io_RVALID;
  wire [31:0]s_axi_pointer_basic_io_WDATA;
  wire s_axi_pointer_basic_io_WREADY;
  wire [3:0]s_axi_pointer_basic_io_WSTRB;
  wire s_axi_pointer_basic_io_WVALID;
  wire [3:3]\NLW_acc_reg[28]_i_1_CO_UNCONNECTED ;

  assign ap_ready = ap_done;
  assign s_axi_pointer_basic_io_BRESP[1] = \<const0> ;
  assign s_axi_pointer_basic_io_BRESP[0] = \<const0> ;
  assign s_axi_pointer_basic_io_RRESP[1] = \<const0> ;
  assign s_axi_pointer_basic_io_RRESP[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[0]_i_2 
       (.I0(d_read_reg_52[3]),
        .I1(acc_reg[3]),
        .O(\acc[0]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[0]_i_3 
       (.I0(d_read_reg_52[2]),
        .I1(acc_reg[2]),
        .O(\acc[0]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[0]_i_4 
       (.I0(d_read_reg_52[1]),
        .I1(acc_reg[1]),
        .O(\acc[0]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[0]_i_5 
       (.I0(d_read_reg_52[0]),
        .I1(acc_reg[0]),
        .O(\acc[0]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[12]_i_2 
       (.I0(d_read_reg_52[15]),
        .I1(acc_reg[15]),
        .O(\acc[12]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[12]_i_3 
       (.I0(d_read_reg_52[14]),
        .I1(acc_reg[14]),
        .O(\acc[12]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[12]_i_4 
       (.I0(d_read_reg_52[13]),
        .I1(acc_reg[13]),
        .O(\acc[12]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[12]_i_5 
       (.I0(d_read_reg_52[12]),
        .I1(acc_reg[12]),
        .O(\acc[12]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[16]_i_2 
       (.I0(d_read_reg_52[19]),
        .I1(acc_reg[19]),
        .O(\acc[16]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[16]_i_3 
       (.I0(d_read_reg_52[18]),
        .I1(acc_reg[18]),
        .O(\acc[16]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[16]_i_4 
       (.I0(d_read_reg_52[17]),
        .I1(acc_reg[17]),
        .O(\acc[16]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[16]_i_5 
       (.I0(d_read_reg_52[16]),
        .I1(acc_reg[16]),
        .O(\acc[16]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[20]_i_2 
       (.I0(d_read_reg_52[23]),
        .I1(acc_reg[23]),
        .O(\acc[20]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[20]_i_3 
       (.I0(d_read_reg_52[22]),
        .I1(acc_reg[22]),
        .O(\acc[20]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[20]_i_4 
       (.I0(d_read_reg_52[21]),
        .I1(acc_reg[21]),
        .O(\acc[20]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[20]_i_5 
       (.I0(d_read_reg_52[20]),
        .I1(acc_reg[20]),
        .O(\acc[20]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[24]_i_2 
       (.I0(d_read_reg_52[27]),
        .I1(acc_reg[27]),
        .O(\acc[24]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[24]_i_3 
       (.I0(d_read_reg_52[26]),
        .I1(acc_reg[26]),
        .O(\acc[24]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[24]_i_4 
       (.I0(d_read_reg_52[25]),
        .I1(acc_reg[25]),
        .O(\acc[24]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[24]_i_5 
       (.I0(d_read_reg_52[24]),
        .I1(acc_reg[24]),
        .O(\acc[24]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[28]_i_2 
       (.I0(acc_reg[31]),
        .I1(d_read_reg_52[31]),
        .O(\acc[28]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[28]_i_3 
       (.I0(d_read_reg_52[30]),
        .I1(acc_reg[30]),
        .O(\acc[28]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[28]_i_4 
       (.I0(d_read_reg_52[29]),
        .I1(acc_reg[29]),
        .O(\acc[28]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[28]_i_5 
       (.I0(d_read_reg_52[28]),
        .I1(acc_reg[28]),
        .O(\acc[28]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[4]_i_2 
       (.I0(d_read_reg_52[7]),
        .I1(acc_reg[7]),
        .O(\acc[4]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[4]_i_3 
       (.I0(d_read_reg_52[6]),
        .I1(acc_reg[6]),
        .O(\acc[4]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[4]_i_4 
       (.I0(d_read_reg_52[5]),
        .I1(acc_reg[5]),
        .O(\acc[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[4]_i_5 
       (.I0(d_read_reg_52[4]),
        .I1(acc_reg[4]),
        .O(\acc[4]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[8]_i_2 
       (.I0(d_read_reg_52[11]),
        .I1(acc_reg[11]),
        .O(\acc[8]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[8]_i_3 
       (.I0(d_read_reg_52[10]),
        .I1(acc_reg[10]),
        .O(\acc[8]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[8]_i_4 
       (.I0(d_read_reg_52[9]),
        .I1(acc_reg[9]),
        .O(\acc[8]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \acc[8]_i_5 
       (.I0(d_read_reg_52[8]),
        .I1(acc_reg[8]),
        .O(\acc[8]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[0] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[0]_i_1_n_7 ),
        .Q(acc_reg[0]),
        .R(1'b0));
  CARRY4 \acc_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\acc_reg[0]_i_1_n_0 ,\acc_reg[0]_i_1_n_1 ,\acc_reg[0]_i_1_n_2 ,\acc_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(d_read_reg_52[3:0]),
        .O({\acc_reg[0]_i_1_n_4 ,\acc_reg[0]_i_1_n_5 ,\acc_reg[0]_i_1_n_6 ,\acc_reg[0]_i_1_n_7 }),
        .S({\acc[0]_i_2_n_0 ,\acc[0]_i_3_n_0 ,\acc[0]_i_4_n_0 ,\acc[0]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[10] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[8]_i_1_n_5 ),
        .Q(acc_reg[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[11] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[8]_i_1_n_4 ),
        .Q(acc_reg[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[12] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[12]_i_1_n_7 ),
        .Q(acc_reg[12]),
        .R(1'b0));
  CARRY4 \acc_reg[12]_i_1 
       (.CI(\acc_reg[8]_i_1_n_0 ),
        .CO({\acc_reg[12]_i_1_n_0 ,\acc_reg[12]_i_1_n_1 ,\acc_reg[12]_i_1_n_2 ,\acc_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(d_read_reg_52[15:12]),
        .O({\acc_reg[12]_i_1_n_4 ,\acc_reg[12]_i_1_n_5 ,\acc_reg[12]_i_1_n_6 ,\acc_reg[12]_i_1_n_7 }),
        .S({\acc[12]_i_2_n_0 ,\acc[12]_i_3_n_0 ,\acc[12]_i_4_n_0 ,\acc[12]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[13] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[12]_i_1_n_6 ),
        .Q(acc_reg[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[14] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[12]_i_1_n_5 ),
        .Q(acc_reg[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[15] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[12]_i_1_n_4 ),
        .Q(acc_reg[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[16] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[16]_i_1_n_7 ),
        .Q(acc_reg[16]),
        .R(1'b0));
  CARRY4 \acc_reg[16]_i_1 
       (.CI(\acc_reg[12]_i_1_n_0 ),
        .CO({\acc_reg[16]_i_1_n_0 ,\acc_reg[16]_i_1_n_1 ,\acc_reg[16]_i_1_n_2 ,\acc_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(d_read_reg_52[19:16]),
        .O({\acc_reg[16]_i_1_n_4 ,\acc_reg[16]_i_1_n_5 ,\acc_reg[16]_i_1_n_6 ,\acc_reg[16]_i_1_n_7 }),
        .S({\acc[16]_i_2_n_0 ,\acc[16]_i_3_n_0 ,\acc[16]_i_4_n_0 ,\acc[16]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[17] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[16]_i_1_n_6 ),
        .Q(acc_reg[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[18] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[16]_i_1_n_5 ),
        .Q(acc_reg[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[19] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[16]_i_1_n_4 ),
        .Q(acc_reg[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[1] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[0]_i_1_n_6 ),
        .Q(acc_reg[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[20] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[20]_i_1_n_7 ),
        .Q(acc_reg[20]),
        .R(1'b0));
  CARRY4 \acc_reg[20]_i_1 
       (.CI(\acc_reg[16]_i_1_n_0 ),
        .CO({\acc_reg[20]_i_1_n_0 ,\acc_reg[20]_i_1_n_1 ,\acc_reg[20]_i_1_n_2 ,\acc_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(d_read_reg_52[23:20]),
        .O({\acc_reg[20]_i_1_n_4 ,\acc_reg[20]_i_1_n_5 ,\acc_reg[20]_i_1_n_6 ,\acc_reg[20]_i_1_n_7 }),
        .S({\acc[20]_i_2_n_0 ,\acc[20]_i_3_n_0 ,\acc[20]_i_4_n_0 ,\acc[20]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[21] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[20]_i_1_n_6 ),
        .Q(acc_reg[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[22] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[20]_i_1_n_5 ),
        .Q(acc_reg[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[23] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[20]_i_1_n_4 ),
        .Q(acc_reg[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[24] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[24]_i_1_n_7 ),
        .Q(acc_reg[24]),
        .R(1'b0));
  CARRY4 \acc_reg[24]_i_1 
       (.CI(\acc_reg[20]_i_1_n_0 ),
        .CO({\acc_reg[24]_i_1_n_0 ,\acc_reg[24]_i_1_n_1 ,\acc_reg[24]_i_1_n_2 ,\acc_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(d_read_reg_52[27:24]),
        .O({\acc_reg[24]_i_1_n_4 ,\acc_reg[24]_i_1_n_5 ,\acc_reg[24]_i_1_n_6 ,\acc_reg[24]_i_1_n_7 }),
        .S({\acc[24]_i_2_n_0 ,\acc[24]_i_3_n_0 ,\acc[24]_i_4_n_0 ,\acc[24]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[25] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[24]_i_1_n_6 ),
        .Q(acc_reg[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[26] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[24]_i_1_n_5 ),
        .Q(acc_reg[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[27] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[24]_i_1_n_4 ),
        .Q(acc_reg[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[28] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[28]_i_1_n_7 ),
        .Q(acc_reg[28]),
        .R(1'b0));
  CARRY4 \acc_reg[28]_i_1 
       (.CI(\acc_reg[24]_i_1_n_0 ),
        .CO({\NLW_acc_reg[28]_i_1_CO_UNCONNECTED [3],\acc_reg[28]_i_1_n_1 ,\acc_reg[28]_i_1_n_2 ,\acc_reg[28]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,d_read_reg_52[30:28]}),
        .O({\acc_reg[28]_i_1_n_4 ,\acc_reg[28]_i_1_n_5 ,\acc_reg[28]_i_1_n_6 ,\acc_reg[28]_i_1_n_7 }),
        .S({\acc[28]_i_2_n_0 ,\acc[28]_i_3_n_0 ,\acc[28]_i_4_n_0 ,\acc[28]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[29] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[28]_i_1_n_6 ),
        .Q(acc_reg[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[2] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[0]_i_1_n_5 ),
        .Q(acc_reg[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[30] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[28]_i_1_n_5 ),
        .Q(acc_reg[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[31] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[28]_i_1_n_4 ),
        .Q(acc_reg[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[3] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[0]_i_1_n_4 ),
        .Q(acc_reg[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[4] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[4]_i_1_n_7 ),
        .Q(acc_reg[4]),
        .R(1'b0));
  CARRY4 \acc_reg[4]_i_1 
       (.CI(\acc_reg[0]_i_1_n_0 ),
        .CO({\acc_reg[4]_i_1_n_0 ,\acc_reg[4]_i_1_n_1 ,\acc_reg[4]_i_1_n_2 ,\acc_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(d_read_reg_52[7:4]),
        .O({\acc_reg[4]_i_1_n_4 ,\acc_reg[4]_i_1_n_5 ,\acc_reg[4]_i_1_n_6 ,\acc_reg[4]_i_1_n_7 }),
        .S({\acc[4]_i_2_n_0 ,\acc[4]_i_3_n_0 ,\acc[4]_i_4_n_0 ,\acc[4]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[5] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[4]_i_1_n_6 ),
        .Q(acc_reg[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[6] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[4]_i_1_n_5 ),
        .Q(acc_reg[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[7] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[4]_i_1_n_4 ),
        .Q(acc_reg[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[8] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[8]_i_1_n_7 ),
        .Q(acc_reg[8]),
        .R(1'b0));
  CARRY4 \acc_reg[8]_i_1 
       (.CI(\acc_reg[4]_i_1_n_0 ),
        .CO({\acc_reg[8]_i_1_n_0 ,\acc_reg[8]_i_1_n_1 ,\acc_reg[8]_i_1_n_2 ,\acc_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(d_read_reg_52[11:8]),
        .O({\acc_reg[8]_i_1_n_4 ,\acc_reg[8]_i_1_n_5 ,\acc_reg[8]_i_1_n_6 ,\acc_reg[8]_i_1_n_7 }),
        .S({\acc[8]_i_2_n_0 ,\acc[8]_i_3_n_0 ,\acc[8]_i_4_n_0 ,\acc[8]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \acc_reg[9] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(\acc_reg[8]_i_1_n_6 ),
        .Q(acc_reg[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT4 #(
    .INIT(16'h4555)) 
    \ap_CS_fsm[0]_i_1 
       (.I0(ap_CS_fsm_state2),
        .I1(ap_done),
        .I2(ap_start),
        .I3(\ap_CS_fsm_reg_n_0_[0] ),
        .O(ap_NS_fsm[0]));
  LUT4 #(
    .INIT(16'h0040)) 
    \ap_CS_fsm[1]_i_1 
       (.I0(ap_done),
        .I1(ap_start),
        .I2(\ap_CS_fsm_reg_n_0_[0] ),
        .I3(ap_CS_fsm_state2),
        .O(ap_NS_fsm[1]));
  (* FSM_ENCODING = "none" *) 
  FDSE #(
    .INIT(1'b1)) 
    \ap_CS_fsm_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[0]),
        .Q(\ap_CS_fsm_reg_n_0_[0] ),
        .S(ap_rst_n_inv));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[1]),
        .Q(ap_CS_fsm_state2),
        .R(ap_rst_n_inv));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_CS_fsm_state2),
        .Q(ap_done),
        .R(ap_rst_n_inv));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h2)) 
    ap_idle_INST_0
       (.I0(\ap_CS_fsm_reg_n_0_[0] ),
        .I1(ap_start),
        .O(ap_idle));
  LUT2 #(
    .INIT(4'h8)) 
    \d_read_reg_52[31]_i_1 
       (.I0(ap_start),
        .I1(\ap_CS_fsm_reg_n_0_[0] ),
        .O(ap_NS_fsm1));
  FDRE \d_read_reg_52_reg[0] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[0]),
        .Q(d_read_reg_52[0]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[10] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[10]),
        .Q(d_read_reg_52[10]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[11] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[11]),
        .Q(d_read_reg_52[11]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[12] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[12]),
        .Q(d_read_reg_52[12]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[13] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[13]),
        .Q(d_read_reg_52[13]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[14] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[14]),
        .Q(d_read_reg_52[14]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[15] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[15]),
        .Q(d_read_reg_52[15]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[16] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[16]),
        .Q(d_read_reg_52[16]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[17] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[17]),
        .Q(d_read_reg_52[17]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[18] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[18]),
        .Q(d_read_reg_52[18]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[19] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[19]),
        .Q(d_read_reg_52[19]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[1] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[1]),
        .Q(d_read_reg_52[1]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[20] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[20]),
        .Q(d_read_reg_52[20]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[21] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[21]),
        .Q(d_read_reg_52[21]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[22] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[22]),
        .Q(d_read_reg_52[22]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[23] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[23]),
        .Q(d_read_reg_52[23]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[24] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[24]),
        .Q(d_read_reg_52[24]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[25] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[25]),
        .Q(d_read_reg_52[25]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[26] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[26]),
        .Q(d_read_reg_52[26]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[27] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[27]),
        .Q(d_read_reg_52[27]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[28] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[28]),
        .Q(d_read_reg_52[28]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[29] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[29]),
        .Q(d_read_reg_52[29]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[2] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[2]),
        .Q(d_read_reg_52[2]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[30] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[30]),
        .Q(d_read_reg_52[30]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[31] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[31]),
        .Q(d_read_reg_52[31]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[3] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[3]),
        .Q(d_read_reg_52[3]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[4] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[4]),
        .Q(d_read_reg_52[4]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[5] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[5]),
        .Q(d_read_reg_52[5]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[6] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[6]),
        .Q(d_read_reg_52[6]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[7] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[7]),
        .Q(d_read_reg_52[7]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[8] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[8]),
        .Q(d_read_reg_52[8]),
        .R(1'b0));
  FDRE \d_read_reg_52_reg[9] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(d_i[9]),
        .Q(d_read_reg_52[9]),
        .R(1'b0));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_pointer_basic_pointer_basic_io_s_axi pointer_basic_pointer_basic_io_s_axi_U
       (.D(acc_reg),
        .Q(d_i),
        .SR(ap_rst_n_inv),
        .\ap_CS_fsm_reg[2] (ap_done),
        .ap_clk(ap_clk),
        .ap_rst_n(ap_rst_n),
        .out({s_axi_pointer_basic_io_BVALID,s_axi_pointer_basic_io_WREADY,s_axi_pointer_basic_io_AWREADY}),
        .s_axi_pointer_basic_io_ARADDR(s_axi_pointer_basic_io_ARADDR),
        .s_axi_pointer_basic_io_ARVALID(s_axi_pointer_basic_io_ARVALID),
        .s_axi_pointer_basic_io_AWADDR(s_axi_pointer_basic_io_AWADDR),
        .s_axi_pointer_basic_io_AWVALID(s_axi_pointer_basic_io_AWVALID),
        .s_axi_pointer_basic_io_BREADY(s_axi_pointer_basic_io_BREADY),
        .s_axi_pointer_basic_io_RDATA(s_axi_pointer_basic_io_RDATA),
        .s_axi_pointer_basic_io_RREADY(s_axi_pointer_basic_io_RREADY),
        .s_axi_pointer_basic_io_RVALID({s_axi_pointer_basic_io_RVALID,s_axi_pointer_basic_io_ARREADY}),
        .s_axi_pointer_basic_io_WDATA(s_axi_pointer_basic_io_WDATA),
        .s_axi_pointer_basic_io_WSTRB(s_axi_pointer_basic_io_WSTRB),
        .s_axi_pointer_basic_io_WVALID(s_axi_pointer_basic_io_WVALID));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_pointer_basic_pointer_basic_io_s_axi
   (out,
    s_axi_pointer_basic_io_RVALID,
    SR,
    Q,
    s_axi_pointer_basic_io_RDATA,
    ap_clk,
    s_axi_pointer_basic_io_ARVALID,
    s_axi_pointer_basic_io_RREADY,
    s_axi_pointer_basic_io_ARADDR,
    s_axi_pointer_basic_io_WDATA,
    s_axi_pointer_basic_io_WSTRB,
    ap_rst_n,
    \ap_CS_fsm_reg[2] ,
    s_axi_pointer_basic_io_AWADDR,
    D,
    s_axi_pointer_basic_io_AWVALID,
    s_axi_pointer_basic_io_BREADY,
    s_axi_pointer_basic_io_WVALID);
  output [2:0]out;
  output [1:0]s_axi_pointer_basic_io_RVALID;
  output [0:0]SR;
  output [31:0]Q;
  output [31:0]s_axi_pointer_basic_io_RDATA;
  input ap_clk;
  input s_axi_pointer_basic_io_ARVALID;
  input s_axi_pointer_basic_io_RREADY;
  input [4:0]s_axi_pointer_basic_io_ARADDR;
  input [31:0]s_axi_pointer_basic_io_WDATA;
  input [3:0]s_axi_pointer_basic_io_WSTRB;
  input ap_rst_n;
  input [0:0]\ap_CS_fsm_reg[2] ;
  input [4:0]s_axi_pointer_basic_io_AWADDR;
  input [31:0]D;
  input s_axi_pointer_basic_io_AWVALID;
  input s_axi_pointer_basic_io_BREADY;
  input s_axi_pointer_basic_io_WVALID;

  wire [31:0]D;
  wire \FSM_onehot_rstate[1]_i_1_n_0 ;
  wire \FSM_onehot_rstate[2]_i_1_n_0 ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_rstate_reg_n_0_[0] ;
  wire \FSM_onehot_wstate[1]_i_1_n_0 ;
  wire \FSM_onehot_wstate[2]_i_1_n_0 ;
  wire \FSM_onehot_wstate[3]_i_1_n_0 ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_wstate_reg_n_0_[0] ;
  wire [31:0]Q;
  wire [0:0]SR;
  wire [0:0]\ap_CS_fsm_reg[2] ;
  wire ap_clk;
  wire ap_rst_n;
  wire ar_hs;
  wire \int_d_i[0]_i_1_n_0 ;
  wire \int_d_i[10]_i_1_n_0 ;
  wire \int_d_i[11]_i_1_n_0 ;
  wire \int_d_i[12]_i_1_n_0 ;
  wire \int_d_i[13]_i_1_n_0 ;
  wire \int_d_i[14]_i_1_n_0 ;
  wire \int_d_i[15]_i_1_n_0 ;
  wire \int_d_i[16]_i_1_n_0 ;
  wire \int_d_i[17]_i_1_n_0 ;
  wire \int_d_i[18]_i_1_n_0 ;
  wire \int_d_i[19]_i_1_n_0 ;
  wire \int_d_i[1]_i_1_n_0 ;
  wire \int_d_i[20]_i_1_n_0 ;
  wire \int_d_i[21]_i_1_n_0 ;
  wire \int_d_i[22]_i_1_n_0 ;
  wire \int_d_i[23]_i_1_n_0 ;
  wire \int_d_i[24]_i_1_n_0 ;
  wire \int_d_i[25]_i_1_n_0 ;
  wire \int_d_i[26]_i_1_n_0 ;
  wire \int_d_i[27]_i_1_n_0 ;
  wire \int_d_i[28]_i_1_n_0 ;
  wire \int_d_i[29]_i_1_n_0 ;
  wire \int_d_i[2]_i_1_n_0 ;
  wire \int_d_i[30]_i_1_n_0 ;
  wire \int_d_i[31]_i_2_n_0 ;
  wire \int_d_i[31]_i_3_n_0 ;
  wire \int_d_i[3]_i_1_n_0 ;
  wire \int_d_i[4]_i_1_n_0 ;
  wire \int_d_i[5]_i_1_n_0 ;
  wire \int_d_i[6]_i_1_n_0 ;
  wire \int_d_i[7]_i_1_n_0 ;
  wire \int_d_i[8]_i_1_n_0 ;
  wire \int_d_i[9]_i_1_n_0 ;
  wire [31:0]int_d_o;
  wire int_d_o_ap_vld;
  wire int_d_o_ap_vld_i_1_n_0;
  wire int_d_o_ap_vld_i_2_n_0;
  (* RTL_KEEP = "yes" *) wire [2:0]out;
  wire p_0_in;
  wire \rdata[0]_i_1_n_0 ;
  wire \rdata[0]_i_2_n_0 ;
  wire \rdata[10]_i_1_n_0 ;
  wire \rdata[11]_i_1_n_0 ;
  wire \rdata[12]_i_1_n_0 ;
  wire \rdata[13]_i_1_n_0 ;
  wire \rdata[14]_i_1_n_0 ;
  wire \rdata[15]_i_1_n_0 ;
  wire \rdata[16]_i_1_n_0 ;
  wire \rdata[17]_i_1_n_0 ;
  wire \rdata[18]_i_1_n_0 ;
  wire \rdata[19]_i_1_n_0 ;
  wire \rdata[1]_i_1_n_0 ;
  wire \rdata[20]_i_1_n_0 ;
  wire \rdata[21]_i_1_n_0 ;
  wire \rdata[22]_i_1_n_0 ;
  wire \rdata[23]_i_1_n_0 ;
  wire \rdata[24]_i_1_n_0 ;
  wire \rdata[25]_i_1_n_0 ;
  wire \rdata[26]_i_1_n_0 ;
  wire \rdata[27]_i_1_n_0 ;
  wire \rdata[28]_i_1_n_0 ;
  wire \rdata[29]_i_1_n_0 ;
  wire \rdata[2]_i_1_n_0 ;
  wire \rdata[30]_i_1_n_0 ;
  wire \rdata[31]_i_1_n_0 ;
  wire \rdata[31]_i_3_n_0 ;
  wire \rdata[3]_i_1_n_0 ;
  wire \rdata[4]_i_1_n_0 ;
  wire \rdata[5]_i_1_n_0 ;
  wire \rdata[6]_i_1_n_0 ;
  wire \rdata[7]_i_1_n_0 ;
  wire \rdata[8]_i_1_n_0 ;
  wire \rdata[9]_i_1_n_0 ;
  wire [4:0]s_axi_pointer_basic_io_ARADDR;
  wire s_axi_pointer_basic_io_ARVALID;
  wire [4:0]s_axi_pointer_basic_io_AWADDR;
  wire s_axi_pointer_basic_io_AWVALID;
  wire s_axi_pointer_basic_io_BREADY;
  wire [31:0]s_axi_pointer_basic_io_RDATA;
  wire s_axi_pointer_basic_io_RREADY;
  (* RTL_KEEP = "yes" *) wire [1:0]s_axi_pointer_basic_io_RVALID;
  wire [31:0]s_axi_pointer_basic_io_WDATA;
  wire [3:0]s_axi_pointer_basic_io_WSTRB;
  wire s_axi_pointer_basic_io_WVALID;
  wire waddr;
  wire \waddr_reg_n_0_[0] ;
  wire \waddr_reg_n_0_[1] ;
  wire \waddr_reg_n_0_[2] ;
  wire \waddr_reg_n_0_[3] ;
  wire \waddr_reg_n_0_[4] ;

  LUT4 #(
    .INIT(16'h8BFB)) 
    \FSM_onehot_rstate[1]_i_1 
       (.I0(s_axi_pointer_basic_io_RREADY),
        .I1(s_axi_pointer_basic_io_RVALID[1]),
        .I2(s_axi_pointer_basic_io_RVALID[0]),
        .I3(s_axi_pointer_basic_io_ARVALID),
        .O(\FSM_onehot_rstate[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h8F88)) 
    \FSM_onehot_rstate[2]_i_1 
       (.I0(s_axi_pointer_basic_io_ARVALID),
        .I1(s_axi_pointer_basic_io_RVALID[0]),
        .I2(s_axi_pointer_basic_io_RREADY),
        .I3(s_axi_pointer_basic_io_RVALID[1]),
        .O(\FSM_onehot_rstate[2]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "RDIDLE:010,RDDATA:100,iSTATE:001" *) 
  (* KEEP = "yes" *) 
  FDSE #(
    .INIT(1'b1)) 
    \FSM_onehot_rstate_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(1'b0),
        .Q(\FSM_onehot_rstate_reg_n_0_[0] ),
        .S(SR));
  (* FSM_ENCODED_STATES = "RDIDLE:010,RDDATA:100,iSTATE:001" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_rstate_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_rstate[1]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RVALID[0]),
        .R(SR));
  (* FSM_ENCODED_STATES = "RDIDLE:010,RDDATA:100,iSTATE:001" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_rstate_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_rstate[2]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RVALID[1]),
        .R(SR));
  LUT5 #(
    .INIT(32'h888BFF8B)) 
    \FSM_onehot_wstate[1]_i_1 
       (.I0(s_axi_pointer_basic_io_BREADY),
        .I1(out[2]),
        .I2(out[1]),
        .I3(out[0]),
        .I4(s_axi_pointer_basic_io_AWVALID),
        .O(\FSM_onehot_wstate[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h8F88)) 
    \FSM_onehot_wstate[2]_i_1 
       (.I0(s_axi_pointer_basic_io_AWVALID),
        .I1(out[0]),
        .I2(s_axi_pointer_basic_io_WVALID),
        .I3(out[1]),
        .O(\FSM_onehot_wstate[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h8F88)) 
    \FSM_onehot_wstate[3]_i_1 
       (.I0(s_axi_pointer_basic_io_WVALID),
        .I1(out[1]),
        .I2(s_axi_pointer_basic_io_BREADY),
        .I3(out[2]),
        .O(\FSM_onehot_wstate[3]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001" *) 
  (* KEEP = "yes" *) 
  FDSE #(
    .INIT(1'b1)) 
    \FSM_onehot_wstate_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(1'b0),
        .Q(\FSM_onehot_wstate_reg_n_0_[0] ),
        .S(SR));
  (* FSM_ENCODED_STATES = "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_wstate_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_wstate[1]_i_1_n_0 ),
        .Q(out[0]),
        .R(SR));
  (* FSM_ENCODED_STATES = "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_wstate_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_wstate[2]_i_1_n_0 ),
        .Q(out[1]),
        .R(SR));
  (* FSM_ENCODED_STATES = "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_wstate_reg[3] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_wstate[3]_i_1_n_0 ),
        .Q(out[2]),
        .R(SR));
  LUT1 #(
    .INIT(2'h1)) 
    \ap_CS_fsm[2]_i_1 
       (.I0(ap_rst_n),
        .O(SR));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[0]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[0]),
        .I1(s_axi_pointer_basic_io_WSTRB[0]),
        .I2(Q[0]),
        .O(\int_d_i[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[10]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[10]),
        .I1(s_axi_pointer_basic_io_WSTRB[1]),
        .I2(Q[10]),
        .O(\int_d_i[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[11]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[11]),
        .I1(s_axi_pointer_basic_io_WSTRB[1]),
        .I2(Q[11]),
        .O(\int_d_i[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[12]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[12]),
        .I1(s_axi_pointer_basic_io_WSTRB[1]),
        .I2(Q[12]),
        .O(\int_d_i[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[13]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[13]),
        .I1(s_axi_pointer_basic_io_WSTRB[1]),
        .I2(Q[13]),
        .O(\int_d_i[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[14]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[14]),
        .I1(s_axi_pointer_basic_io_WSTRB[1]),
        .I2(Q[14]),
        .O(\int_d_i[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[15]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[15]),
        .I1(s_axi_pointer_basic_io_WSTRB[1]),
        .I2(Q[15]),
        .O(\int_d_i[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[16]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[16]),
        .I1(s_axi_pointer_basic_io_WSTRB[2]),
        .I2(Q[16]),
        .O(\int_d_i[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[17]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[17]),
        .I1(s_axi_pointer_basic_io_WSTRB[2]),
        .I2(Q[17]),
        .O(\int_d_i[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[18]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[18]),
        .I1(s_axi_pointer_basic_io_WSTRB[2]),
        .I2(Q[18]),
        .O(\int_d_i[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[19]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[19]),
        .I1(s_axi_pointer_basic_io_WSTRB[2]),
        .I2(Q[19]),
        .O(\int_d_i[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[1]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[1]),
        .I1(s_axi_pointer_basic_io_WSTRB[0]),
        .I2(Q[1]),
        .O(\int_d_i[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[20]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[20]),
        .I1(s_axi_pointer_basic_io_WSTRB[2]),
        .I2(Q[20]),
        .O(\int_d_i[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[21]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[21]),
        .I1(s_axi_pointer_basic_io_WSTRB[2]),
        .I2(Q[21]),
        .O(\int_d_i[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[22]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[22]),
        .I1(s_axi_pointer_basic_io_WSTRB[2]),
        .I2(Q[22]),
        .O(\int_d_i[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[23]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[23]),
        .I1(s_axi_pointer_basic_io_WSTRB[2]),
        .I2(Q[23]),
        .O(\int_d_i[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[24]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[24]),
        .I1(s_axi_pointer_basic_io_WSTRB[3]),
        .I2(Q[24]),
        .O(\int_d_i[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[25]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[25]),
        .I1(s_axi_pointer_basic_io_WSTRB[3]),
        .I2(Q[25]),
        .O(\int_d_i[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[26]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[26]),
        .I1(s_axi_pointer_basic_io_WSTRB[3]),
        .I2(Q[26]),
        .O(\int_d_i[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[27]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[27]),
        .I1(s_axi_pointer_basic_io_WSTRB[3]),
        .I2(Q[27]),
        .O(\int_d_i[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[28]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[28]),
        .I1(s_axi_pointer_basic_io_WSTRB[3]),
        .I2(Q[28]),
        .O(\int_d_i[28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[29]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[29]),
        .I1(s_axi_pointer_basic_io_WSTRB[3]),
        .I2(Q[29]),
        .O(\int_d_i[29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[2]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[2]),
        .I1(s_axi_pointer_basic_io_WSTRB[0]),
        .I2(Q[2]),
        .O(\int_d_i[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[30]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[30]),
        .I1(s_axi_pointer_basic_io_WSTRB[3]),
        .I2(Q[30]),
        .O(\int_d_i[30]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \int_d_i[31]_i_1 
       (.I0(s_axi_pointer_basic_io_WVALID),
        .I1(\int_d_i[31]_i_3_n_0 ),
        .O(p_0_in));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[31]_i_2 
       (.I0(s_axi_pointer_basic_io_WDATA[31]),
        .I1(s_axi_pointer_basic_io_WSTRB[3]),
        .I2(Q[31]),
        .O(\int_d_i[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0001000000000000)) 
    \int_d_i[31]_i_3 
       (.I0(\waddr_reg_n_0_[0] ),
        .I1(\waddr_reg_n_0_[3] ),
        .I2(\waddr_reg_n_0_[1] ),
        .I3(\waddr_reg_n_0_[2] ),
        .I4(\waddr_reg_n_0_[4] ),
        .I5(out[1]),
        .O(\int_d_i[31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[3]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[3]),
        .I1(s_axi_pointer_basic_io_WSTRB[0]),
        .I2(Q[3]),
        .O(\int_d_i[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[4]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[4]),
        .I1(s_axi_pointer_basic_io_WSTRB[0]),
        .I2(Q[4]),
        .O(\int_d_i[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[5]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[5]),
        .I1(s_axi_pointer_basic_io_WSTRB[0]),
        .I2(Q[5]),
        .O(\int_d_i[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[6]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[6]),
        .I1(s_axi_pointer_basic_io_WSTRB[0]),
        .I2(Q[6]),
        .O(\int_d_i[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[7]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[7]),
        .I1(s_axi_pointer_basic_io_WSTRB[0]),
        .I2(Q[7]),
        .O(\int_d_i[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[8]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[8]),
        .I1(s_axi_pointer_basic_io_WSTRB[1]),
        .I2(Q[8]),
        .O(\int_d_i[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_d_i[9]_i_1 
       (.I0(s_axi_pointer_basic_io_WDATA[9]),
        .I1(s_axi_pointer_basic_io_WSTRB[1]),
        .I2(Q[9]),
        .O(\int_d_i[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[0] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[0]_i_1_n_0 ),
        .Q(Q[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[10] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[10]_i_1_n_0 ),
        .Q(Q[10]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[11] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[11]_i_1_n_0 ),
        .Q(Q[11]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[12] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[12]_i_1_n_0 ),
        .Q(Q[12]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[13] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[13]_i_1_n_0 ),
        .Q(Q[13]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[14] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[14]_i_1_n_0 ),
        .Q(Q[14]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[15] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[15]_i_1_n_0 ),
        .Q(Q[15]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[16] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[16]_i_1_n_0 ),
        .Q(Q[16]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[17] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[17]_i_1_n_0 ),
        .Q(Q[17]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[18] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[18]_i_1_n_0 ),
        .Q(Q[18]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[19] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[19]_i_1_n_0 ),
        .Q(Q[19]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[1] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[1]_i_1_n_0 ),
        .Q(Q[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[20] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[20]_i_1_n_0 ),
        .Q(Q[20]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[21] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[21]_i_1_n_0 ),
        .Q(Q[21]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[22] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[22]_i_1_n_0 ),
        .Q(Q[22]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[23] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[23]_i_1_n_0 ),
        .Q(Q[23]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[24] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[24]_i_1_n_0 ),
        .Q(Q[24]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[25] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[25]_i_1_n_0 ),
        .Q(Q[25]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[26] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[26]_i_1_n_0 ),
        .Q(Q[26]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[27] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[27]_i_1_n_0 ),
        .Q(Q[27]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[28] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[28]_i_1_n_0 ),
        .Q(Q[28]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[29] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[29]_i_1_n_0 ),
        .Q(Q[29]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[2] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[2]_i_1_n_0 ),
        .Q(Q[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[30] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[30]_i_1_n_0 ),
        .Q(Q[30]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[31] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[31]_i_2_n_0 ),
        .Q(Q[31]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[3] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[3]_i_1_n_0 ),
        .Q(Q[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[4] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[4]_i_1_n_0 ),
        .Q(Q[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[5] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[5]_i_1_n_0 ),
        .Q(Q[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[6] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[6]_i_1_n_0 ),
        .Q(Q[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[7] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[7]_i_1_n_0 ),
        .Q(Q[7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[8] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[8]_i_1_n_0 ),
        .Q(Q[8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_i_reg[9] 
       (.C(ap_clk),
        .CE(p_0_in),
        .D(\int_d_i[9]_i_1_n_0 ),
        .Q(Q[9]),
        .R(SR));
  LUT6 #(
    .INIT(64'hFFFFBFFFAAAAAAAA)) 
    int_d_o_ap_vld_i_1
       (.I0(\ap_CS_fsm_reg[2] ),
        .I1(ar_hs),
        .I2(s_axi_pointer_basic_io_ARADDR[3]),
        .I3(s_axi_pointer_basic_io_ARADDR[2]),
        .I4(int_d_o_ap_vld_i_2_n_0),
        .I5(int_d_o_ap_vld),
        .O(int_d_o_ap_vld_i_1_n_0));
  LUT3 #(
    .INIT(8'hFB)) 
    int_d_o_ap_vld_i_2
       (.I0(s_axi_pointer_basic_io_ARADDR[1]),
        .I1(s_axi_pointer_basic_io_ARADDR[4]),
        .I2(s_axi_pointer_basic_io_ARADDR[0]),
        .O(int_d_o_ap_vld_i_2_n_0));
  FDRE int_d_o_ap_vld_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(int_d_o_ap_vld_i_1_n_0),
        .Q(int_d_o_ap_vld),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[0] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[0]),
        .Q(int_d_o[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[10] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[10]),
        .Q(int_d_o[10]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[11] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[11]),
        .Q(int_d_o[11]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[12] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[12]),
        .Q(int_d_o[12]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[13] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[13]),
        .Q(int_d_o[13]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[14] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[14]),
        .Q(int_d_o[14]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[15] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[15]),
        .Q(int_d_o[15]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[16] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[16]),
        .Q(int_d_o[16]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[17] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[17]),
        .Q(int_d_o[17]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[18] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[18]),
        .Q(int_d_o[18]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[19] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[19]),
        .Q(int_d_o[19]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[1] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[1]),
        .Q(int_d_o[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[20] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[20]),
        .Q(int_d_o[20]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[21] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[21]),
        .Q(int_d_o[21]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[22] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[22]),
        .Q(int_d_o[22]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[23] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[23]),
        .Q(int_d_o[23]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[24] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[24]),
        .Q(int_d_o[24]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[25] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[25]),
        .Q(int_d_o[25]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[26] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[26]),
        .Q(int_d_o[26]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[27] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[27]),
        .Q(int_d_o[27]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[28] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[28]),
        .Q(int_d_o[28]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[29] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[29]),
        .Q(int_d_o[29]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[2] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[2]),
        .Q(int_d_o[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[30] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[30]),
        .Q(int_d_o[30]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[31] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[31]),
        .Q(int_d_o[31]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[3] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[3]),
        .Q(int_d_o[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[4] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[4]),
        .Q(int_d_o[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[5] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[5]),
        .Q(int_d_o[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[6] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[6]),
        .Q(int_d_o[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[7] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[7]),
        .Q(int_d_o[7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[8] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[8]),
        .Q(int_d_o[8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_d_o_reg[9] 
       (.C(ap_clk),
        .CE(\ap_CS_fsm_reg[2] ),
        .D(D[9]),
        .Q(int_d_o[9]),
        .R(SR));
  LUT6 #(
    .INIT(64'h0020FFFF00200000)) 
    \rdata[0]_i_1 
       (.I0(\rdata[0]_i_2_n_0 ),
        .I1(s_axi_pointer_basic_io_ARADDR[0]),
        .I2(s_axi_pointer_basic_io_ARADDR[4]),
        .I3(s_axi_pointer_basic_io_ARADDR[1]),
        .I4(ar_hs),
        .I5(s_axi_pointer_basic_io_RDATA[0]),
        .O(\rdata[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0CFC0)) 
    \rdata[0]_i_2 
       (.I0(int_d_o_ap_vld),
        .I1(int_d_o[0]),
        .I2(s_axi_pointer_basic_io_ARADDR[3]),
        .I3(Q[0]),
        .I4(s_axi_pointer_basic_io_ARADDR[2]),
        .O(\rdata[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[10]_i_1 
       (.I0(int_d_o[10]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[10]),
        .O(\rdata[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[11]_i_1 
       (.I0(int_d_o[11]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[11]),
        .O(\rdata[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[12]_i_1 
       (.I0(int_d_o[12]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[12]),
        .O(\rdata[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[13]_i_1 
       (.I0(int_d_o[13]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[13]),
        .O(\rdata[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[14]_i_1 
       (.I0(int_d_o[14]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[14]),
        .O(\rdata[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[15]_i_1 
       (.I0(int_d_o[15]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[15]),
        .O(\rdata[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[16]_i_1 
       (.I0(int_d_o[16]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[16]),
        .O(\rdata[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[17]_i_1 
       (.I0(int_d_o[17]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[17]),
        .O(\rdata[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[18]_i_1 
       (.I0(int_d_o[18]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[18]),
        .O(\rdata[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[19]_i_1 
       (.I0(int_d_o[19]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[19]),
        .O(\rdata[19]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[1]_i_1 
       (.I0(int_d_o[1]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[1]),
        .O(\rdata[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[20]_i_1 
       (.I0(int_d_o[20]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[20]),
        .O(\rdata[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[21]_i_1 
       (.I0(int_d_o[21]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[21]),
        .O(\rdata[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[22]_i_1 
       (.I0(int_d_o[22]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[22]),
        .O(\rdata[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[23]_i_1 
       (.I0(int_d_o[23]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[23]),
        .O(\rdata[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[24]_i_1 
       (.I0(int_d_o[24]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[24]),
        .O(\rdata[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[25]_i_1 
       (.I0(int_d_o[25]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[25]),
        .O(\rdata[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[26]_i_1 
       (.I0(int_d_o[26]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[26]),
        .O(\rdata[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[27]_i_1 
       (.I0(int_d_o[27]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[27]),
        .O(\rdata[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[28]_i_1 
       (.I0(int_d_o[28]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[28]),
        .O(\rdata[28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[29]_i_1 
       (.I0(int_d_o[29]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[29]),
        .O(\rdata[29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[2]_i_1 
       (.I0(int_d_o[2]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[2]),
        .O(\rdata[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[30]_i_1 
       (.I0(int_d_o[30]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[30]),
        .O(\rdata[30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFB000000000000)) 
    \rdata[31]_i_1 
       (.I0(s_axi_pointer_basic_io_ARADDR[1]),
        .I1(s_axi_pointer_basic_io_ARADDR[4]),
        .I2(s_axi_pointer_basic_io_ARADDR[0]),
        .I3(s_axi_pointer_basic_io_ARADDR[2]),
        .I4(s_axi_pointer_basic_io_ARVALID),
        .I5(s_axi_pointer_basic_io_RVALID[0]),
        .O(\rdata[31]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \rdata[31]_i_2 
       (.I0(s_axi_pointer_basic_io_RVALID[0]),
        .I1(s_axi_pointer_basic_io_ARVALID),
        .O(ar_hs));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[31]_i_3 
       (.I0(int_d_o[31]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[31]),
        .O(\rdata[31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[3]_i_1 
       (.I0(int_d_o[3]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[3]),
        .O(\rdata[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[4]_i_1 
       (.I0(int_d_o[4]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[4]),
        .O(\rdata[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[5]_i_1 
       (.I0(int_d_o[5]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[5]),
        .O(\rdata[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[6]_i_1 
       (.I0(int_d_o[6]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[6]),
        .O(\rdata[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[7]_i_1 
       (.I0(int_d_o[7]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[7]),
        .O(\rdata[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[8]_i_1 
       (.I0(int_d_o[8]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[8]),
        .O(\rdata[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[9]_i_1 
       (.I0(int_d_o[9]),
        .I1(s_axi_pointer_basic_io_ARADDR[3]),
        .I2(Q[9]),
        .O(\rdata[9]_i_1_n_0 ));
  FDRE \rdata_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\rdata[0]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[0]),
        .R(1'b0));
  FDRE \rdata_reg[10] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[10]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[10]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[11] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[11]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[11]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[12] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[12]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[12]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[13] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[13]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[13]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[14] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[14]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[14]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[15] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[15]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[15]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[16] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[16]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[16]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[17] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[17]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[17]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[18] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[18]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[18]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[19] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[19]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[19]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[1] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[1]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[1]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[20] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[20]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[20]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[21] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[21]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[21]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[22] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[22]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[22]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[23] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[23]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[23]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[24] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[24]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[24]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[25] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[25]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[25]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[26] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[26]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[26]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[27] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[27]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[27]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[28] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[28]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[28]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[29] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[29]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[29]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[2] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[2]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[2]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[30] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[30]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[30]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[31] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[31]_i_3_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[31]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[3] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[3]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[3]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[4] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[4]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[4]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[5] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[5]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[5]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[6] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[6]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[6]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[7] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[7]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[7]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[8] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[8]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[8]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[9] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[9]_i_1_n_0 ),
        .Q(s_axi_pointer_basic_io_RDATA[9]),
        .R(\rdata[31]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \waddr[4]_i_1 
       (.I0(s_axi_pointer_basic_io_AWVALID),
        .I1(out[0]),
        .O(waddr));
  FDRE \waddr_reg[0] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_pointer_basic_io_AWADDR[0]),
        .Q(\waddr_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \waddr_reg[1] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_pointer_basic_io_AWADDR[1]),
        .Q(\waddr_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \waddr_reg[2] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_pointer_basic_io_AWADDR[2]),
        .Q(\waddr_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \waddr_reg[3] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_pointer_basic_io_AWADDR[3]),
        .Q(\waddr_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \waddr_reg[4] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_pointer_basic_io_AWADDR[4]),
        .Q(\waddr_reg_n_0_[4] ),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
