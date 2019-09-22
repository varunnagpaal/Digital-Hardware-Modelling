// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sun Sep 22 03:32:37 2019
// Host        : varun-laptop running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               d:/github/Digital-Hardware-Modelling/xilinx-vivado/gcd/gcd.srcs/sources_1/bd/gcd_block_design/ip/gcd_block_design_gcd_0_1/gcd_block_design_gcd_0_1_sim_netlist.v
// Design      : gcd_block_design_gcd_0_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "gcd_block_design_gcd_0_1,gcd,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "HLS" *) 
(* X_CORE_INFO = "gcd,Vivado 2018.2" *) (* hls_module = "yes" *) 
(* NotValidForBitStream *)
module gcd_block_design_gcd_0_1
   (s_axi_gcd_bus_AWADDR,
    s_axi_gcd_bus_AWVALID,
    s_axi_gcd_bus_AWREADY,
    s_axi_gcd_bus_WDATA,
    s_axi_gcd_bus_WSTRB,
    s_axi_gcd_bus_WVALID,
    s_axi_gcd_bus_WREADY,
    s_axi_gcd_bus_BRESP,
    s_axi_gcd_bus_BVALID,
    s_axi_gcd_bus_BREADY,
    s_axi_gcd_bus_ARADDR,
    s_axi_gcd_bus_ARVALID,
    s_axi_gcd_bus_ARREADY,
    s_axi_gcd_bus_RDATA,
    s_axi_gcd_bus_RRESP,
    s_axi_gcd_bus_RVALID,
    s_axi_gcd_bus_RREADY,
    ap_clk,
    ap_rst_n,
    interrupt);
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus AWADDR" *) input [5:0]s_axi_gcd_bus_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus AWVALID" *) input s_axi_gcd_bus_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus AWREADY" *) output s_axi_gcd_bus_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus WDATA" *) input [31:0]s_axi_gcd_bus_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus WSTRB" *) input [3:0]s_axi_gcd_bus_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus WVALID" *) input s_axi_gcd_bus_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus WREADY" *) output s_axi_gcd_bus_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus BRESP" *) output [1:0]s_axi_gcd_bus_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus BVALID" *) output s_axi_gcd_bus_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus BREADY" *) input s_axi_gcd_bus_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus ARADDR" *) input [5:0]s_axi_gcd_bus_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus ARVALID" *) input s_axi_gcd_bus_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus ARREADY" *) output s_axi_gcd_bus_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus RDATA" *) output [31:0]s_axi_gcd_bus_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus RRESP" *) output [1:0]s_axi_gcd_bus_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus RVALID" *) output s_axi_gcd_bus_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_gcd_bus RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_gcd_bus, ADDR_WIDTH 6, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {CLK {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN gcd_block_design_processing_system7_0_2_FCLK_CLK0, NUM_READ_THREADS 4, NUM_WRITE_THREADS 4, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0" *) input s_axi_gcd_bus_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF s_axi_gcd_bus, ASSOCIATED_RESET ap_rst_n, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {CLK {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN gcd_block_design_processing_system7_0_2_FCLK_CLK0" *) input ap_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {RST {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}" *) input ap_rst_n;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 interrupt INTERRUPT" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME interrupt, SENSITIVITY LEVEL_HIGH, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {INTERRUPT {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}, PortWidth 1" *) output interrupt;

  wire ap_clk;
  wire ap_rst_n;
  wire interrupt;
  wire [5:0]s_axi_gcd_bus_ARADDR;
  wire s_axi_gcd_bus_ARREADY;
  wire s_axi_gcd_bus_ARVALID;
  wire [5:0]s_axi_gcd_bus_AWADDR;
  wire s_axi_gcd_bus_AWREADY;
  wire s_axi_gcd_bus_AWVALID;
  wire s_axi_gcd_bus_BREADY;
  wire [1:0]s_axi_gcd_bus_BRESP;
  wire s_axi_gcd_bus_BVALID;
  wire [31:0]s_axi_gcd_bus_RDATA;
  wire s_axi_gcd_bus_RREADY;
  wire [1:0]s_axi_gcd_bus_RRESP;
  wire s_axi_gcd_bus_RVALID;
  wire [31:0]s_axi_gcd_bus_WDATA;
  wire s_axi_gcd_bus_WREADY;
  wire [3:0]s_axi_gcd_bus_WSTRB;
  wire s_axi_gcd_bus_WVALID;

  (* C_S_AXI_DATA_WIDTH = "32" *) 
  (* C_S_AXI_GCD_BUS_ADDR_WIDTH = "6" *) 
  (* C_S_AXI_GCD_BUS_DATA_WIDTH = "32" *) 
  (* C_S_AXI_GCD_BUS_WSTRB_WIDTH = "4" *) 
  (* C_S_AXI_WSTRB_WIDTH = "4" *) 
  (* ap_ST_fsm_state1 = "4'b0001" *) 
  (* ap_ST_fsm_state2 = "4'b0010" *) 
  (* ap_ST_fsm_state3 = "4'b0100" *) 
  (* ap_ST_fsm_state4 = "4'b1000" *) 
  gcd_block_design_gcd_0_1_gcd inst
       (.ap_clk(ap_clk),
        .ap_rst_n(ap_rst_n),
        .interrupt(interrupt),
        .s_axi_gcd_bus_ARADDR(s_axi_gcd_bus_ARADDR),
        .s_axi_gcd_bus_ARREADY(s_axi_gcd_bus_ARREADY),
        .s_axi_gcd_bus_ARVALID(s_axi_gcd_bus_ARVALID),
        .s_axi_gcd_bus_AWADDR(s_axi_gcd_bus_AWADDR),
        .s_axi_gcd_bus_AWREADY(s_axi_gcd_bus_AWREADY),
        .s_axi_gcd_bus_AWVALID(s_axi_gcd_bus_AWVALID),
        .s_axi_gcd_bus_BREADY(s_axi_gcd_bus_BREADY),
        .s_axi_gcd_bus_BRESP(s_axi_gcd_bus_BRESP),
        .s_axi_gcd_bus_BVALID(s_axi_gcd_bus_BVALID),
        .s_axi_gcd_bus_RDATA(s_axi_gcd_bus_RDATA),
        .s_axi_gcd_bus_RREADY(s_axi_gcd_bus_RREADY),
        .s_axi_gcd_bus_RRESP(s_axi_gcd_bus_RRESP),
        .s_axi_gcd_bus_RVALID(s_axi_gcd_bus_RVALID),
        .s_axi_gcd_bus_WDATA(s_axi_gcd_bus_WDATA),
        .s_axi_gcd_bus_WREADY(s_axi_gcd_bus_WREADY),
        .s_axi_gcd_bus_WSTRB(s_axi_gcd_bus_WSTRB),
        .s_axi_gcd_bus_WVALID(s_axi_gcd_bus_WVALID));
endmodule

(* C_S_AXI_DATA_WIDTH = "32" *) (* C_S_AXI_GCD_BUS_ADDR_WIDTH = "6" *) (* C_S_AXI_GCD_BUS_DATA_WIDTH = "32" *) 
(* C_S_AXI_GCD_BUS_WSTRB_WIDTH = "4" *) (* C_S_AXI_WSTRB_WIDTH = "4" *) (* ORIG_REF_NAME = "gcd" *) 
(* ap_ST_fsm_state1 = "4'b0001" *) (* ap_ST_fsm_state2 = "4'b0010" *) (* ap_ST_fsm_state3 = "4'b0100" *) 
(* ap_ST_fsm_state4 = "4'b1000" *) (* hls_module = "yes" *) 
module gcd_block_design_gcd_0_1_gcd
   (ap_clk,
    ap_rst_n,
    s_axi_gcd_bus_AWVALID,
    s_axi_gcd_bus_AWREADY,
    s_axi_gcd_bus_AWADDR,
    s_axi_gcd_bus_WVALID,
    s_axi_gcd_bus_WREADY,
    s_axi_gcd_bus_WDATA,
    s_axi_gcd_bus_WSTRB,
    s_axi_gcd_bus_ARVALID,
    s_axi_gcd_bus_ARREADY,
    s_axi_gcd_bus_ARADDR,
    s_axi_gcd_bus_RVALID,
    s_axi_gcd_bus_RREADY,
    s_axi_gcd_bus_RDATA,
    s_axi_gcd_bus_RRESP,
    s_axi_gcd_bus_BVALID,
    s_axi_gcd_bus_BREADY,
    s_axi_gcd_bus_BRESP,
    interrupt);
  input ap_clk;
  input ap_rst_n;
  input s_axi_gcd_bus_AWVALID;
  output s_axi_gcd_bus_AWREADY;
  input [5:0]s_axi_gcd_bus_AWADDR;
  input s_axi_gcd_bus_WVALID;
  output s_axi_gcd_bus_WREADY;
  input [31:0]s_axi_gcd_bus_WDATA;
  input [3:0]s_axi_gcd_bus_WSTRB;
  input s_axi_gcd_bus_ARVALID;
  output s_axi_gcd_bus_ARREADY;
  input [5:0]s_axi_gcd_bus_ARADDR;
  output s_axi_gcd_bus_RVALID;
  input s_axi_gcd_bus_RREADY;
  output [31:0]s_axi_gcd_bus_RDATA;
  output [1:0]s_axi_gcd_bus_RRESP;
  output s_axi_gcd_bus_BVALID;
  input s_axi_gcd_bus_BREADY;
  output [1:0]s_axi_gcd_bus_BRESP;
  output interrupt;

  wire \<const0> ;
  wire [15:0]a;
  wire [15:0]a_assign_fu_78_p21_out;
  wire [15:0]a_assign_reg_121;
  wire a_assign_reg_1210;
  wire \a_assign_reg_121[11]_i_2_n_0 ;
  wire \a_assign_reg_121[11]_i_3_n_0 ;
  wire \a_assign_reg_121[11]_i_4_n_0 ;
  wire \a_assign_reg_121[11]_i_5_n_0 ;
  wire \a_assign_reg_121[15]_i_2_n_0 ;
  wire \a_assign_reg_121[15]_i_3_n_0 ;
  wire \a_assign_reg_121[15]_i_4_n_0 ;
  wire \a_assign_reg_121[15]_i_5_n_0 ;
  wire \a_assign_reg_121[3]_i_2_n_0 ;
  wire \a_assign_reg_121[3]_i_3_n_0 ;
  wire \a_assign_reg_121[3]_i_4_n_0 ;
  wire \a_assign_reg_121[3]_i_5_n_0 ;
  wire \a_assign_reg_121[7]_i_2_n_0 ;
  wire \a_assign_reg_121[7]_i_3_n_0 ;
  wire \a_assign_reg_121[7]_i_4_n_0 ;
  wire \a_assign_reg_121[7]_i_5_n_0 ;
  wire \a_assign_reg_121_reg[11]_i_1_n_0 ;
  wire \a_assign_reg_121_reg[11]_i_1_n_1 ;
  wire \a_assign_reg_121_reg[11]_i_1_n_2 ;
  wire \a_assign_reg_121_reg[11]_i_1_n_3 ;
  wire \a_assign_reg_121_reg[15]_i_1_n_1 ;
  wire \a_assign_reg_121_reg[15]_i_1_n_2 ;
  wire \a_assign_reg_121_reg[15]_i_1_n_3 ;
  wire \a_assign_reg_121_reg[3]_i_1_n_0 ;
  wire \a_assign_reg_121_reg[3]_i_1_n_1 ;
  wire \a_assign_reg_121_reg[3]_i_1_n_2 ;
  wire \a_assign_reg_121_reg[3]_i_1_n_3 ;
  wire \a_assign_reg_121_reg[7]_i_1_n_0 ;
  wire \a_assign_reg_121_reg[7]_i_1_n_1 ;
  wire \a_assign_reg_121_reg[7]_i_1_n_2 ;
  wire \a_assign_reg_121_reg[7]_i_1_n_3 ;
  wire [15:0]a_read_reg_107;
  wire \ap_CS_fsm_reg_n_0_[0] ;
  wire ap_CS_fsm_state2;
  wire ap_CS_fsm_state3;
  wire ap_CS_fsm_state4;
  wire [2:0]ap_NS_fsm;
  wire ap_NS_fsm1;
  wire ap_clk;
  wire ap_rst_n;
  wire ap_rst_n_inv;
  wire [15:0]b;
  wire [15:0]b_assign_fu_84_p20_out;
  wire [15:0]b_assign_reg_126;
  wire \b_assign_reg_126[11]_i_2_n_0 ;
  wire \b_assign_reg_126[11]_i_3_n_0 ;
  wire \b_assign_reg_126[11]_i_4_n_0 ;
  wire \b_assign_reg_126[11]_i_5_n_0 ;
  wire \b_assign_reg_126[15]_i_2_n_0 ;
  wire \b_assign_reg_126[15]_i_3_n_0 ;
  wire \b_assign_reg_126[15]_i_4_n_0 ;
  wire \b_assign_reg_126[15]_i_5_n_0 ;
  wire \b_assign_reg_126[3]_i_2_n_0 ;
  wire \b_assign_reg_126[3]_i_3_n_0 ;
  wire \b_assign_reg_126[3]_i_4_n_0 ;
  wire \b_assign_reg_126[3]_i_5_n_0 ;
  wire \b_assign_reg_126[7]_i_2_n_0 ;
  wire \b_assign_reg_126[7]_i_3_n_0 ;
  wire \b_assign_reg_126[7]_i_4_n_0 ;
  wire \b_assign_reg_126[7]_i_5_n_0 ;
  wire \b_assign_reg_126_reg[11]_i_1_n_0 ;
  wire \b_assign_reg_126_reg[11]_i_1_n_1 ;
  wire \b_assign_reg_126_reg[11]_i_1_n_2 ;
  wire \b_assign_reg_126_reg[11]_i_1_n_3 ;
  wire \b_assign_reg_126_reg[15]_i_1_n_1 ;
  wire \b_assign_reg_126_reg[15]_i_1_n_2 ;
  wire \b_assign_reg_126_reg[15]_i_1_n_3 ;
  wire \b_assign_reg_126_reg[3]_i_1_n_0 ;
  wire \b_assign_reg_126_reg[3]_i_1_n_1 ;
  wire \b_assign_reg_126_reg[3]_i_1_n_2 ;
  wire \b_assign_reg_126_reg[3]_i_1_n_3 ;
  wire \b_assign_reg_126_reg[7]_i_1_n_0 ;
  wire \b_assign_reg_126_reg[7]_i_1_n_1 ;
  wire \b_assign_reg_126_reg[7]_i_1_n_2 ;
  wire \b_assign_reg_126_reg[7]_i_1_n_3 ;
  wire [15:0]b_read_reg_102;
  wire interrupt;
  wire [15:0]p_1_in;
  wire [15:0]p_s_reg_45;
  wire \p_s_reg_45[0]_i_1_n_0 ;
  wire \p_s_reg_45[10]_i_1_n_0 ;
  wire \p_s_reg_45[11]_i_1_n_0 ;
  wire \p_s_reg_45[12]_i_1_n_0 ;
  wire \p_s_reg_45[13]_i_1_n_0 ;
  wire \p_s_reg_45[14]_i_1_n_0 ;
  wire \p_s_reg_45[15]_i_1_n_0 ;
  wire \p_s_reg_45[15]_i_2_n_0 ;
  wire \p_s_reg_45[1]_i_1_n_0 ;
  wire \p_s_reg_45[2]_i_1_n_0 ;
  wire \p_s_reg_45[3]_i_1_n_0 ;
  wire \p_s_reg_45[4]_i_1_n_0 ;
  wire \p_s_reg_45[5]_i_1_n_0 ;
  wire \p_s_reg_45[6]_i_1_n_0 ;
  wire \p_s_reg_45[7]_i_1_n_0 ;
  wire \p_s_reg_45[8]_i_1_n_0 ;
  wire \p_s_reg_45[9]_i_1_n_0 ;
  wire [15:0]result_reg_56;
  wire \result_reg_56[15]_i_1_n_0 ;
  wire [5:0]s_axi_gcd_bus_ARADDR;
  wire s_axi_gcd_bus_ARREADY;
  wire s_axi_gcd_bus_ARVALID;
  wire [5:0]s_axi_gcd_bus_AWADDR;
  wire s_axi_gcd_bus_AWREADY;
  wire s_axi_gcd_bus_AWVALID;
  wire s_axi_gcd_bus_BREADY;
  wire s_axi_gcd_bus_BVALID;
  wire [15:0]\^s_axi_gcd_bus_RDATA ;
  wire s_axi_gcd_bus_RREADY;
  wire s_axi_gcd_bus_RVALID;
  wire [31:0]s_axi_gcd_bus_WDATA;
  wire s_axi_gcd_bus_WREADY;
  wire [3:0]s_axi_gcd_bus_WSTRB;
  wire s_axi_gcd_bus_WVALID;
  wire tmp_2_fu_66_p2;
  wire tmp_3_fu_72_p2;
  wire tmp_3_reg_115;
  wire \tmp_3_reg_115[0]_i_10_n_0 ;
  wire \tmp_3_reg_115[0]_i_11_n_0 ;
  wire \tmp_3_reg_115[0]_i_12_n_0 ;
  wire \tmp_3_reg_115[0]_i_13_n_0 ;
  wire \tmp_3_reg_115[0]_i_14_n_0 ;
  wire \tmp_3_reg_115[0]_i_15_n_0 ;
  wire \tmp_3_reg_115[0]_i_16_n_0 ;
  wire \tmp_3_reg_115[0]_i_17_n_0 ;
  wire \tmp_3_reg_115[0]_i_18_n_0 ;
  wire \tmp_3_reg_115[0]_i_3_n_0 ;
  wire \tmp_3_reg_115[0]_i_4_n_0 ;
  wire \tmp_3_reg_115[0]_i_5_n_0 ;
  wire \tmp_3_reg_115[0]_i_6_n_0 ;
  wire \tmp_3_reg_115[0]_i_7_n_0 ;
  wire \tmp_3_reg_115[0]_i_8_n_0 ;
  wire \tmp_3_reg_115[0]_i_9_n_0 ;
  wire \tmp_3_reg_115_reg[0]_i_1_n_1 ;
  wire \tmp_3_reg_115_reg[0]_i_1_n_2 ;
  wire \tmp_3_reg_115_reg[0]_i_1_n_3 ;
  wire \tmp_3_reg_115_reg[0]_i_2_n_0 ;
  wire \tmp_3_reg_115_reg[0]_i_2_n_1 ;
  wire \tmp_3_reg_115_reg[0]_i_2_n_2 ;
  wire \tmp_3_reg_115_reg[0]_i_2_n_3 ;
  wire [3:3]\NLW_a_assign_reg_121_reg[15]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_b_assign_reg_126_reg[15]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_tmp_3_reg_115_reg[0]_i_1_O_UNCONNECTED ;
  wire [3:0]\NLW_tmp_3_reg_115_reg[0]_i_2_O_UNCONNECTED ;

  assign s_axi_gcd_bus_BRESP[1] = \<const0> ;
  assign s_axi_gcd_bus_BRESP[0] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[31] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[30] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[29] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[28] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[27] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[26] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[25] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[24] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[23] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[22] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[21] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[20] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[19] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[18] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[17] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[16] = \<const0> ;
  assign s_axi_gcd_bus_RDATA[15:0] = \^s_axi_gcd_bus_RDATA [15:0];
  assign s_axi_gcd_bus_RRESP[1] = \<const0> ;
  assign s_axi_gcd_bus_RRESP[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  LUT2 #(
    .INIT(4'h9)) 
    \a_assign_reg_121[11]_i_2 
       (.I0(result_reg_56[11]),
        .I1(p_s_reg_45[11]),
        .O(\a_assign_reg_121[11]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \a_assign_reg_121[11]_i_3 
       (.I0(result_reg_56[10]),
        .I1(p_s_reg_45[10]),
        .O(\a_assign_reg_121[11]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \a_assign_reg_121[11]_i_4 
       (.I0(result_reg_56[9]),
        .I1(p_s_reg_45[9]),
        .O(\a_assign_reg_121[11]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \a_assign_reg_121[11]_i_5 
       (.I0(result_reg_56[8]),
        .I1(p_s_reg_45[8]),
        .O(\a_assign_reg_121[11]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \a_assign_reg_121[15]_i_2 
       (.I0(result_reg_56[15]),
        .I1(p_s_reg_45[15]),
        .O(\a_assign_reg_121[15]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \a_assign_reg_121[15]_i_3 
       (.I0(result_reg_56[14]),
        .I1(p_s_reg_45[14]),
        .O(\a_assign_reg_121[15]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \a_assign_reg_121[15]_i_4 
       (.I0(result_reg_56[13]),
        .I1(p_s_reg_45[13]),
        .O(\a_assign_reg_121[15]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \a_assign_reg_121[15]_i_5 
       (.I0(result_reg_56[12]),
        .I1(p_s_reg_45[12]),
        .O(\a_assign_reg_121[15]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \a_assign_reg_121[3]_i_2 
       (.I0(result_reg_56[3]),
        .I1(p_s_reg_45[3]),
        .O(\a_assign_reg_121[3]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \a_assign_reg_121[3]_i_3 
       (.I0(result_reg_56[2]),
        .I1(p_s_reg_45[2]),
        .O(\a_assign_reg_121[3]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \a_assign_reg_121[3]_i_4 
       (.I0(result_reg_56[1]),
        .I1(p_s_reg_45[1]),
        .O(\a_assign_reg_121[3]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \a_assign_reg_121[3]_i_5 
       (.I0(result_reg_56[0]),
        .I1(p_s_reg_45[0]),
        .O(\a_assign_reg_121[3]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \a_assign_reg_121[7]_i_2 
       (.I0(result_reg_56[7]),
        .I1(p_s_reg_45[7]),
        .O(\a_assign_reg_121[7]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \a_assign_reg_121[7]_i_3 
       (.I0(result_reg_56[6]),
        .I1(p_s_reg_45[6]),
        .O(\a_assign_reg_121[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \a_assign_reg_121[7]_i_4 
       (.I0(result_reg_56[5]),
        .I1(p_s_reg_45[5]),
        .O(\a_assign_reg_121[7]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \a_assign_reg_121[7]_i_5 
       (.I0(result_reg_56[4]),
        .I1(p_s_reg_45[4]),
        .O(\a_assign_reg_121[7]_i_5_n_0 ));
  FDRE \a_assign_reg_121_reg[0] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(a_assign_fu_78_p21_out[0]),
        .Q(a_assign_reg_121[0]),
        .R(1'b0));
  FDRE \a_assign_reg_121_reg[10] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(a_assign_fu_78_p21_out[10]),
        .Q(a_assign_reg_121[10]),
        .R(1'b0));
  FDRE \a_assign_reg_121_reg[11] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(a_assign_fu_78_p21_out[11]),
        .Q(a_assign_reg_121[11]),
        .R(1'b0));
  CARRY4 \a_assign_reg_121_reg[11]_i_1 
       (.CI(\a_assign_reg_121_reg[7]_i_1_n_0 ),
        .CO({\a_assign_reg_121_reg[11]_i_1_n_0 ,\a_assign_reg_121_reg[11]_i_1_n_1 ,\a_assign_reg_121_reg[11]_i_1_n_2 ,\a_assign_reg_121_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(result_reg_56[11:8]),
        .O(a_assign_fu_78_p21_out[11:8]),
        .S({\a_assign_reg_121[11]_i_2_n_0 ,\a_assign_reg_121[11]_i_3_n_0 ,\a_assign_reg_121[11]_i_4_n_0 ,\a_assign_reg_121[11]_i_5_n_0 }));
  FDRE \a_assign_reg_121_reg[12] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(a_assign_fu_78_p21_out[12]),
        .Q(a_assign_reg_121[12]),
        .R(1'b0));
  FDRE \a_assign_reg_121_reg[13] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(a_assign_fu_78_p21_out[13]),
        .Q(a_assign_reg_121[13]),
        .R(1'b0));
  FDRE \a_assign_reg_121_reg[14] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(a_assign_fu_78_p21_out[14]),
        .Q(a_assign_reg_121[14]),
        .R(1'b0));
  FDRE \a_assign_reg_121_reg[15] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(a_assign_fu_78_p21_out[15]),
        .Q(a_assign_reg_121[15]),
        .R(1'b0));
  CARRY4 \a_assign_reg_121_reg[15]_i_1 
       (.CI(\a_assign_reg_121_reg[11]_i_1_n_0 ),
        .CO({\NLW_a_assign_reg_121_reg[15]_i_1_CO_UNCONNECTED [3],\a_assign_reg_121_reg[15]_i_1_n_1 ,\a_assign_reg_121_reg[15]_i_1_n_2 ,\a_assign_reg_121_reg[15]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,result_reg_56[14:12]}),
        .O(a_assign_fu_78_p21_out[15:12]),
        .S({\a_assign_reg_121[15]_i_2_n_0 ,\a_assign_reg_121[15]_i_3_n_0 ,\a_assign_reg_121[15]_i_4_n_0 ,\a_assign_reg_121[15]_i_5_n_0 }));
  FDRE \a_assign_reg_121_reg[1] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(a_assign_fu_78_p21_out[1]),
        .Q(a_assign_reg_121[1]),
        .R(1'b0));
  FDRE \a_assign_reg_121_reg[2] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(a_assign_fu_78_p21_out[2]),
        .Q(a_assign_reg_121[2]),
        .R(1'b0));
  FDRE \a_assign_reg_121_reg[3] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(a_assign_fu_78_p21_out[3]),
        .Q(a_assign_reg_121[3]),
        .R(1'b0));
  CARRY4 \a_assign_reg_121_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\a_assign_reg_121_reg[3]_i_1_n_0 ,\a_assign_reg_121_reg[3]_i_1_n_1 ,\a_assign_reg_121_reg[3]_i_1_n_2 ,\a_assign_reg_121_reg[3]_i_1_n_3 }),
        .CYINIT(1'b1),
        .DI(result_reg_56[3:0]),
        .O(a_assign_fu_78_p21_out[3:0]),
        .S({\a_assign_reg_121[3]_i_2_n_0 ,\a_assign_reg_121[3]_i_3_n_0 ,\a_assign_reg_121[3]_i_4_n_0 ,\a_assign_reg_121[3]_i_5_n_0 }));
  FDRE \a_assign_reg_121_reg[4] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(a_assign_fu_78_p21_out[4]),
        .Q(a_assign_reg_121[4]),
        .R(1'b0));
  FDRE \a_assign_reg_121_reg[5] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(a_assign_fu_78_p21_out[5]),
        .Q(a_assign_reg_121[5]),
        .R(1'b0));
  FDRE \a_assign_reg_121_reg[6] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(a_assign_fu_78_p21_out[6]),
        .Q(a_assign_reg_121[6]),
        .R(1'b0));
  FDRE \a_assign_reg_121_reg[7] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(a_assign_fu_78_p21_out[7]),
        .Q(a_assign_reg_121[7]),
        .R(1'b0));
  CARRY4 \a_assign_reg_121_reg[7]_i_1 
       (.CI(\a_assign_reg_121_reg[3]_i_1_n_0 ),
        .CO({\a_assign_reg_121_reg[7]_i_1_n_0 ,\a_assign_reg_121_reg[7]_i_1_n_1 ,\a_assign_reg_121_reg[7]_i_1_n_2 ,\a_assign_reg_121_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(result_reg_56[7:4]),
        .O(a_assign_fu_78_p21_out[7:4]),
        .S({\a_assign_reg_121[7]_i_2_n_0 ,\a_assign_reg_121[7]_i_3_n_0 ,\a_assign_reg_121[7]_i_4_n_0 ,\a_assign_reg_121[7]_i_5_n_0 }));
  FDRE \a_assign_reg_121_reg[8] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(a_assign_fu_78_p21_out[8]),
        .Q(a_assign_reg_121[8]),
        .R(1'b0));
  FDRE \a_assign_reg_121_reg[9] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(a_assign_fu_78_p21_out[9]),
        .Q(a_assign_reg_121[9]),
        .R(1'b0));
  FDRE \a_read_reg_107_reg[0] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(a[0]),
        .Q(a_read_reg_107[0]),
        .R(1'b0));
  FDRE \a_read_reg_107_reg[10] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(a[10]),
        .Q(a_read_reg_107[10]),
        .R(1'b0));
  FDRE \a_read_reg_107_reg[11] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(a[11]),
        .Q(a_read_reg_107[11]),
        .R(1'b0));
  FDRE \a_read_reg_107_reg[12] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(a[12]),
        .Q(a_read_reg_107[12]),
        .R(1'b0));
  FDRE \a_read_reg_107_reg[13] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(a[13]),
        .Q(a_read_reg_107[13]),
        .R(1'b0));
  FDRE \a_read_reg_107_reg[14] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(a[14]),
        .Q(a_read_reg_107[14]),
        .R(1'b0));
  FDRE \a_read_reg_107_reg[15] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(a[15]),
        .Q(a_read_reg_107[15]),
        .R(1'b0));
  FDRE \a_read_reg_107_reg[1] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(a[1]),
        .Q(a_read_reg_107[1]),
        .R(1'b0));
  FDRE \a_read_reg_107_reg[2] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(a[2]),
        .Q(a_read_reg_107[2]),
        .R(1'b0));
  FDRE \a_read_reg_107_reg[3] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(a[3]),
        .Q(a_read_reg_107[3]),
        .R(1'b0));
  FDRE \a_read_reg_107_reg[4] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(a[4]),
        .Q(a_read_reg_107[4]),
        .R(1'b0));
  FDRE \a_read_reg_107_reg[5] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(a[5]),
        .Q(a_read_reg_107[5]),
        .R(1'b0));
  FDRE \a_read_reg_107_reg[6] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(a[6]),
        .Q(a_read_reg_107[6]),
        .R(1'b0));
  FDRE \a_read_reg_107_reg[7] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(a[7]),
        .Q(a_read_reg_107[7]),
        .R(1'b0));
  FDRE \a_read_reg_107_reg[8] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(a[8]),
        .Q(a_read_reg_107[8]),
        .R(1'b0));
  FDRE \a_read_reg_107_reg[9] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(a[9]),
        .Q(a_read_reg_107[9]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'hE)) 
    \ap_CS_fsm[2]_i_1 
       (.I0(ap_CS_fsm_state2),
        .I1(ap_CS_fsm_state4),
        .O(ap_NS_fsm[2]));
  LUT2 #(
    .INIT(4'h2)) 
    \ap_CS_fsm[3]_i_1 
       (.I0(ap_CS_fsm_state3),
        .I1(tmp_2_fu_66_p2),
        .O(a_assign_reg_1210));
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
        .D(ap_NS_fsm[2]),
        .Q(ap_CS_fsm_state3),
        .R(ap_rst_n_inv));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[3] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(a_assign_reg_1210),
        .Q(ap_CS_fsm_state4),
        .R(ap_rst_n_inv));
  LUT2 #(
    .INIT(4'h9)) 
    \b_assign_reg_126[11]_i_2 
       (.I0(p_s_reg_45[11]),
        .I1(result_reg_56[11]),
        .O(\b_assign_reg_126[11]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \b_assign_reg_126[11]_i_3 
       (.I0(p_s_reg_45[10]),
        .I1(result_reg_56[10]),
        .O(\b_assign_reg_126[11]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \b_assign_reg_126[11]_i_4 
       (.I0(p_s_reg_45[9]),
        .I1(result_reg_56[9]),
        .O(\b_assign_reg_126[11]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \b_assign_reg_126[11]_i_5 
       (.I0(p_s_reg_45[8]),
        .I1(result_reg_56[8]),
        .O(\b_assign_reg_126[11]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \b_assign_reg_126[15]_i_2 
       (.I0(p_s_reg_45[15]),
        .I1(result_reg_56[15]),
        .O(\b_assign_reg_126[15]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \b_assign_reg_126[15]_i_3 
       (.I0(p_s_reg_45[14]),
        .I1(result_reg_56[14]),
        .O(\b_assign_reg_126[15]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \b_assign_reg_126[15]_i_4 
       (.I0(p_s_reg_45[13]),
        .I1(result_reg_56[13]),
        .O(\b_assign_reg_126[15]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \b_assign_reg_126[15]_i_5 
       (.I0(p_s_reg_45[12]),
        .I1(result_reg_56[12]),
        .O(\b_assign_reg_126[15]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \b_assign_reg_126[3]_i_2 
       (.I0(p_s_reg_45[3]),
        .I1(result_reg_56[3]),
        .O(\b_assign_reg_126[3]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \b_assign_reg_126[3]_i_3 
       (.I0(p_s_reg_45[2]),
        .I1(result_reg_56[2]),
        .O(\b_assign_reg_126[3]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \b_assign_reg_126[3]_i_4 
       (.I0(p_s_reg_45[1]),
        .I1(result_reg_56[1]),
        .O(\b_assign_reg_126[3]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \b_assign_reg_126[3]_i_5 
       (.I0(p_s_reg_45[0]),
        .I1(result_reg_56[0]),
        .O(\b_assign_reg_126[3]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \b_assign_reg_126[7]_i_2 
       (.I0(p_s_reg_45[7]),
        .I1(result_reg_56[7]),
        .O(\b_assign_reg_126[7]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \b_assign_reg_126[7]_i_3 
       (.I0(p_s_reg_45[6]),
        .I1(result_reg_56[6]),
        .O(\b_assign_reg_126[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \b_assign_reg_126[7]_i_4 
       (.I0(p_s_reg_45[5]),
        .I1(result_reg_56[5]),
        .O(\b_assign_reg_126[7]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \b_assign_reg_126[7]_i_5 
       (.I0(p_s_reg_45[4]),
        .I1(result_reg_56[4]),
        .O(\b_assign_reg_126[7]_i_5_n_0 ));
  FDRE \b_assign_reg_126_reg[0] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(b_assign_fu_84_p20_out[0]),
        .Q(b_assign_reg_126[0]),
        .R(1'b0));
  FDRE \b_assign_reg_126_reg[10] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(b_assign_fu_84_p20_out[10]),
        .Q(b_assign_reg_126[10]),
        .R(1'b0));
  FDRE \b_assign_reg_126_reg[11] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(b_assign_fu_84_p20_out[11]),
        .Q(b_assign_reg_126[11]),
        .R(1'b0));
  CARRY4 \b_assign_reg_126_reg[11]_i_1 
       (.CI(\b_assign_reg_126_reg[7]_i_1_n_0 ),
        .CO({\b_assign_reg_126_reg[11]_i_1_n_0 ,\b_assign_reg_126_reg[11]_i_1_n_1 ,\b_assign_reg_126_reg[11]_i_1_n_2 ,\b_assign_reg_126_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(p_s_reg_45[11:8]),
        .O(b_assign_fu_84_p20_out[11:8]),
        .S({\b_assign_reg_126[11]_i_2_n_0 ,\b_assign_reg_126[11]_i_3_n_0 ,\b_assign_reg_126[11]_i_4_n_0 ,\b_assign_reg_126[11]_i_5_n_0 }));
  FDRE \b_assign_reg_126_reg[12] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(b_assign_fu_84_p20_out[12]),
        .Q(b_assign_reg_126[12]),
        .R(1'b0));
  FDRE \b_assign_reg_126_reg[13] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(b_assign_fu_84_p20_out[13]),
        .Q(b_assign_reg_126[13]),
        .R(1'b0));
  FDRE \b_assign_reg_126_reg[14] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(b_assign_fu_84_p20_out[14]),
        .Q(b_assign_reg_126[14]),
        .R(1'b0));
  FDRE \b_assign_reg_126_reg[15] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(b_assign_fu_84_p20_out[15]),
        .Q(b_assign_reg_126[15]),
        .R(1'b0));
  CARRY4 \b_assign_reg_126_reg[15]_i_1 
       (.CI(\b_assign_reg_126_reg[11]_i_1_n_0 ),
        .CO({\NLW_b_assign_reg_126_reg[15]_i_1_CO_UNCONNECTED [3],\b_assign_reg_126_reg[15]_i_1_n_1 ,\b_assign_reg_126_reg[15]_i_1_n_2 ,\b_assign_reg_126_reg[15]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,p_s_reg_45[14:12]}),
        .O(b_assign_fu_84_p20_out[15:12]),
        .S({\b_assign_reg_126[15]_i_2_n_0 ,\b_assign_reg_126[15]_i_3_n_0 ,\b_assign_reg_126[15]_i_4_n_0 ,\b_assign_reg_126[15]_i_5_n_0 }));
  FDRE \b_assign_reg_126_reg[1] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(b_assign_fu_84_p20_out[1]),
        .Q(b_assign_reg_126[1]),
        .R(1'b0));
  FDRE \b_assign_reg_126_reg[2] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(b_assign_fu_84_p20_out[2]),
        .Q(b_assign_reg_126[2]),
        .R(1'b0));
  FDRE \b_assign_reg_126_reg[3] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(b_assign_fu_84_p20_out[3]),
        .Q(b_assign_reg_126[3]),
        .R(1'b0));
  CARRY4 \b_assign_reg_126_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\b_assign_reg_126_reg[3]_i_1_n_0 ,\b_assign_reg_126_reg[3]_i_1_n_1 ,\b_assign_reg_126_reg[3]_i_1_n_2 ,\b_assign_reg_126_reg[3]_i_1_n_3 }),
        .CYINIT(1'b1),
        .DI(p_s_reg_45[3:0]),
        .O(b_assign_fu_84_p20_out[3:0]),
        .S({\b_assign_reg_126[3]_i_2_n_0 ,\b_assign_reg_126[3]_i_3_n_0 ,\b_assign_reg_126[3]_i_4_n_0 ,\b_assign_reg_126[3]_i_5_n_0 }));
  FDRE \b_assign_reg_126_reg[4] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(b_assign_fu_84_p20_out[4]),
        .Q(b_assign_reg_126[4]),
        .R(1'b0));
  FDRE \b_assign_reg_126_reg[5] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(b_assign_fu_84_p20_out[5]),
        .Q(b_assign_reg_126[5]),
        .R(1'b0));
  FDRE \b_assign_reg_126_reg[6] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(b_assign_fu_84_p20_out[6]),
        .Q(b_assign_reg_126[6]),
        .R(1'b0));
  FDRE \b_assign_reg_126_reg[7] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(b_assign_fu_84_p20_out[7]),
        .Q(b_assign_reg_126[7]),
        .R(1'b0));
  CARRY4 \b_assign_reg_126_reg[7]_i_1 
       (.CI(\b_assign_reg_126_reg[3]_i_1_n_0 ),
        .CO({\b_assign_reg_126_reg[7]_i_1_n_0 ,\b_assign_reg_126_reg[7]_i_1_n_1 ,\b_assign_reg_126_reg[7]_i_1_n_2 ,\b_assign_reg_126_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(p_s_reg_45[7:4]),
        .O(b_assign_fu_84_p20_out[7:4]),
        .S({\b_assign_reg_126[7]_i_2_n_0 ,\b_assign_reg_126[7]_i_3_n_0 ,\b_assign_reg_126[7]_i_4_n_0 ,\b_assign_reg_126[7]_i_5_n_0 }));
  FDRE \b_assign_reg_126_reg[8] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(b_assign_fu_84_p20_out[8]),
        .Q(b_assign_reg_126[8]),
        .R(1'b0));
  FDRE \b_assign_reg_126_reg[9] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(b_assign_fu_84_p20_out[9]),
        .Q(b_assign_reg_126[9]),
        .R(1'b0));
  FDRE \b_read_reg_102_reg[0] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(b[0]),
        .Q(b_read_reg_102[0]),
        .R(1'b0));
  FDRE \b_read_reg_102_reg[10] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(b[10]),
        .Q(b_read_reg_102[10]),
        .R(1'b0));
  FDRE \b_read_reg_102_reg[11] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(b[11]),
        .Q(b_read_reg_102[11]),
        .R(1'b0));
  FDRE \b_read_reg_102_reg[12] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(b[12]),
        .Q(b_read_reg_102[12]),
        .R(1'b0));
  FDRE \b_read_reg_102_reg[13] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(b[13]),
        .Q(b_read_reg_102[13]),
        .R(1'b0));
  FDRE \b_read_reg_102_reg[14] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(b[14]),
        .Q(b_read_reg_102[14]),
        .R(1'b0));
  FDRE \b_read_reg_102_reg[15] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(b[15]),
        .Q(b_read_reg_102[15]),
        .R(1'b0));
  FDRE \b_read_reg_102_reg[1] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(b[1]),
        .Q(b_read_reg_102[1]),
        .R(1'b0));
  FDRE \b_read_reg_102_reg[2] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(b[2]),
        .Q(b_read_reg_102[2]),
        .R(1'b0));
  FDRE \b_read_reg_102_reg[3] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(b[3]),
        .Q(b_read_reg_102[3]),
        .R(1'b0));
  FDRE \b_read_reg_102_reg[4] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(b[4]),
        .Q(b_read_reg_102[4]),
        .R(1'b0));
  FDRE \b_read_reg_102_reg[5] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(b[5]),
        .Q(b_read_reg_102[5]),
        .R(1'b0));
  FDRE \b_read_reg_102_reg[6] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(b[6]),
        .Q(b_read_reg_102[6]),
        .R(1'b0));
  FDRE \b_read_reg_102_reg[7] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(b[7]),
        .Q(b_read_reg_102[7]),
        .R(1'b0));
  FDRE \b_read_reg_102_reg[8] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(b[8]),
        .Q(b_read_reg_102[8]),
        .R(1'b0));
  FDRE \b_read_reg_102_reg[9] 
       (.C(ap_clk),
        .CE(ap_NS_fsm1),
        .D(b[9]),
        .Q(b_read_reg_102[9]),
        .R(1'b0));
  gcd_block_design_gcd_0_1_gcd_gcd_bus_s_axi gcd_gcd_bus_s_axi_U
       (.CO(tmp_2_fu_66_p2),
        .D(ap_NS_fsm[1:0]),
        .E(ap_NS_fsm1),
        .Q({ap_CS_fsm_state4,ap_CS_fsm_state3,ap_CS_fsm_state2,\ap_CS_fsm_reg_n_0_[0] }),
        .SR(ap_rst_n_inv),
        .\a_read_reg_107_reg[15] (a),
        .ap_clk(ap_clk),
        .ap_rst_n(ap_rst_n),
        .\b_read_reg_102_reg[15] (b),
        .interrupt(interrupt),
        .out({s_axi_gcd_bus_BVALID,s_axi_gcd_bus_WREADY,s_axi_gcd_bus_AWREADY}),
        .\p_s_reg_45_reg[15] (p_s_reg_45),
        .\result_reg_56_reg[15] (result_reg_56),
        .s_axi_gcd_bus_ARADDR(s_axi_gcd_bus_ARADDR),
        .s_axi_gcd_bus_ARVALID(s_axi_gcd_bus_ARVALID),
        .s_axi_gcd_bus_AWADDR(s_axi_gcd_bus_AWADDR),
        .s_axi_gcd_bus_AWVALID(s_axi_gcd_bus_AWVALID),
        .s_axi_gcd_bus_BREADY(s_axi_gcd_bus_BREADY),
        .s_axi_gcd_bus_RDATA(\^s_axi_gcd_bus_RDATA ),
        .s_axi_gcd_bus_RREADY(s_axi_gcd_bus_RREADY),
        .s_axi_gcd_bus_RVALID({s_axi_gcd_bus_RVALID,s_axi_gcd_bus_ARREADY}),
        .s_axi_gcd_bus_WDATA(s_axi_gcd_bus_WDATA[15:0]),
        .s_axi_gcd_bus_WSTRB(s_axi_gcd_bus_WSTRB[1:0]),
        .s_axi_gcd_bus_WVALID(s_axi_gcd_bus_WVALID));
  LUT3 #(
    .INIT(8'hAC)) 
    \p_s_reg_45[0]_i_1 
       (.I0(b_assign_reg_126[0]),
        .I1(b_read_reg_102[0]),
        .I2(ap_CS_fsm_state4),
        .O(\p_s_reg_45[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \p_s_reg_45[10]_i_1 
       (.I0(b_assign_reg_126[10]),
        .I1(b_read_reg_102[10]),
        .I2(ap_CS_fsm_state4),
        .O(\p_s_reg_45[10]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \p_s_reg_45[11]_i_1 
       (.I0(b_assign_reg_126[11]),
        .I1(b_read_reg_102[11]),
        .I2(ap_CS_fsm_state4),
        .O(\p_s_reg_45[11]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \p_s_reg_45[12]_i_1 
       (.I0(b_assign_reg_126[12]),
        .I1(b_read_reg_102[12]),
        .I2(ap_CS_fsm_state4),
        .O(\p_s_reg_45[12]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \p_s_reg_45[13]_i_1 
       (.I0(b_assign_reg_126[13]),
        .I1(b_read_reg_102[13]),
        .I2(ap_CS_fsm_state4),
        .O(\p_s_reg_45[13]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \p_s_reg_45[14]_i_1 
       (.I0(b_assign_reg_126[14]),
        .I1(b_read_reg_102[14]),
        .I2(ap_CS_fsm_state4),
        .O(\p_s_reg_45[14]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h74)) 
    \p_s_reg_45[15]_i_1 
       (.I0(tmp_3_reg_115),
        .I1(ap_CS_fsm_state4),
        .I2(ap_CS_fsm_state2),
        .O(\p_s_reg_45[15]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \p_s_reg_45[15]_i_2 
       (.I0(b_assign_reg_126[15]),
        .I1(b_read_reg_102[15]),
        .I2(ap_CS_fsm_state4),
        .O(\p_s_reg_45[15]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \p_s_reg_45[1]_i_1 
       (.I0(b_assign_reg_126[1]),
        .I1(b_read_reg_102[1]),
        .I2(ap_CS_fsm_state4),
        .O(\p_s_reg_45[1]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \p_s_reg_45[2]_i_1 
       (.I0(b_assign_reg_126[2]),
        .I1(b_read_reg_102[2]),
        .I2(ap_CS_fsm_state4),
        .O(\p_s_reg_45[2]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \p_s_reg_45[3]_i_1 
       (.I0(b_assign_reg_126[3]),
        .I1(b_read_reg_102[3]),
        .I2(ap_CS_fsm_state4),
        .O(\p_s_reg_45[3]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \p_s_reg_45[4]_i_1 
       (.I0(b_assign_reg_126[4]),
        .I1(b_read_reg_102[4]),
        .I2(ap_CS_fsm_state4),
        .O(\p_s_reg_45[4]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \p_s_reg_45[5]_i_1 
       (.I0(b_assign_reg_126[5]),
        .I1(b_read_reg_102[5]),
        .I2(ap_CS_fsm_state4),
        .O(\p_s_reg_45[5]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \p_s_reg_45[6]_i_1 
       (.I0(b_assign_reg_126[6]),
        .I1(b_read_reg_102[6]),
        .I2(ap_CS_fsm_state4),
        .O(\p_s_reg_45[6]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \p_s_reg_45[7]_i_1 
       (.I0(b_assign_reg_126[7]),
        .I1(b_read_reg_102[7]),
        .I2(ap_CS_fsm_state4),
        .O(\p_s_reg_45[7]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \p_s_reg_45[8]_i_1 
       (.I0(b_assign_reg_126[8]),
        .I1(b_read_reg_102[8]),
        .I2(ap_CS_fsm_state4),
        .O(\p_s_reg_45[8]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \p_s_reg_45[9]_i_1 
       (.I0(b_assign_reg_126[9]),
        .I1(b_read_reg_102[9]),
        .I2(ap_CS_fsm_state4),
        .O(\p_s_reg_45[9]_i_1_n_0 ));
  FDRE \p_s_reg_45_reg[0] 
       (.C(ap_clk),
        .CE(\p_s_reg_45[15]_i_1_n_0 ),
        .D(\p_s_reg_45[0]_i_1_n_0 ),
        .Q(p_s_reg_45[0]),
        .R(1'b0));
  FDRE \p_s_reg_45_reg[10] 
       (.C(ap_clk),
        .CE(\p_s_reg_45[15]_i_1_n_0 ),
        .D(\p_s_reg_45[10]_i_1_n_0 ),
        .Q(p_s_reg_45[10]),
        .R(1'b0));
  FDRE \p_s_reg_45_reg[11] 
       (.C(ap_clk),
        .CE(\p_s_reg_45[15]_i_1_n_0 ),
        .D(\p_s_reg_45[11]_i_1_n_0 ),
        .Q(p_s_reg_45[11]),
        .R(1'b0));
  FDRE \p_s_reg_45_reg[12] 
       (.C(ap_clk),
        .CE(\p_s_reg_45[15]_i_1_n_0 ),
        .D(\p_s_reg_45[12]_i_1_n_0 ),
        .Q(p_s_reg_45[12]),
        .R(1'b0));
  FDRE \p_s_reg_45_reg[13] 
       (.C(ap_clk),
        .CE(\p_s_reg_45[15]_i_1_n_0 ),
        .D(\p_s_reg_45[13]_i_1_n_0 ),
        .Q(p_s_reg_45[13]),
        .R(1'b0));
  FDRE \p_s_reg_45_reg[14] 
       (.C(ap_clk),
        .CE(\p_s_reg_45[15]_i_1_n_0 ),
        .D(\p_s_reg_45[14]_i_1_n_0 ),
        .Q(p_s_reg_45[14]),
        .R(1'b0));
  FDRE \p_s_reg_45_reg[15] 
       (.C(ap_clk),
        .CE(\p_s_reg_45[15]_i_1_n_0 ),
        .D(\p_s_reg_45[15]_i_2_n_0 ),
        .Q(p_s_reg_45[15]),
        .R(1'b0));
  FDRE \p_s_reg_45_reg[1] 
       (.C(ap_clk),
        .CE(\p_s_reg_45[15]_i_1_n_0 ),
        .D(\p_s_reg_45[1]_i_1_n_0 ),
        .Q(p_s_reg_45[1]),
        .R(1'b0));
  FDRE \p_s_reg_45_reg[2] 
       (.C(ap_clk),
        .CE(\p_s_reg_45[15]_i_1_n_0 ),
        .D(\p_s_reg_45[2]_i_1_n_0 ),
        .Q(p_s_reg_45[2]),
        .R(1'b0));
  FDRE \p_s_reg_45_reg[3] 
       (.C(ap_clk),
        .CE(\p_s_reg_45[15]_i_1_n_0 ),
        .D(\p_s_reg_45[3]_i_1_n_0 ),
        .Q(p_s_reg_45[3]),
        .R(1'b0));
  FDRE \p_s_reg_45_reg[4] 
       (.C(ap_clk),
        .CE(\p_s_reg_45[15]_i_1_n_0 ),
        .D(\p_s_reg_45[4]_i_1_n_0 ),
        .Q(p_s_reg_45[4]),
        .R(1'b0));
  FDRE \p_s_reg_45_reg[5] 
       (.C(ap_clk),
        .CE(\p_s_reg_45[15]_i_1_n_0 ),
        .D(\p_s_reg_45[5]_i_1_n_0 ),
        .Q(p_s_reg_45[5]),
        .R(1'b0));
  FDRE \p_s_reg_45_reg[6] 
       (.C(ap_clk),
        .CE(\p_s_reg_45[15]_i_1_n_0 ),
        .D(\p_s_reg_45[6]_i_1_n_0 ),
        .Q(p_s_reg_45[6]),
        .R(1'b0));
  FDRE \p_s_reg_45_reg[7] 
       (.C(ap_clk),
        .CE(\p_s_reg_45[15]_i_1_n_0 ),
        .D(\p_s_reg_45[7]_i_1_n_0 ),
        .Q(p_s_reg_45[7]),
        .R(1'b0));
  FDRE \p_s_reg_45_reg[8] 
       (.C(ap_clk),
        .CE(\p_s_reg_45[15]_i_1_n_0 ),
        .D(\p_s_reg_45[8]_i_1_n_0 ),
        .Q(p_s_reg_45[8]),
        .R(1'b0));
  FDRE \p_s_reg_45_reg[9] 
       (.C(ap_clk),
        .CE(\p_s_reg_45[15]_i_1_n_0 ),
        .D(\p_s_reg_45[9]_i_1_n_0 ),
        .Q(p_s_reg_45[9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hAC)) 
    \result_reg_56[0]_i_1 
       (.I0(a_assign_reg_121[0]),
        .I1(a_read_reg_107[0]),
        .I2(ap_CS_fsm_state4),
        .O(p_1_in[0]));
  LUT3 #(
    .INIT(8'hAC)) 
    \result_reg_56[10]_i_1 
       (.I0(a_assign_reg_121[10]),
        .I1(a_read_reg_107[10]),
        .I2(ap_CS_fsm_state4),
        .O(p_1_in[10]));
  LUT3 #(
    .INIT(8'hAC)) 
    \result_reg_56[11]_i_1 
       (.I0(a_assign_reg_121[11]),
        .I1(a_read_reg_107[11]),
        .I2(ap_CS_fsm_state4),
        .O(p_1_in[11]));
  LUT3 #(
    .INIT(8'hAC)) 
    \result_reg_56[12]_i_1 
       (.I0(a_assign_reg_121[12]),
        .I1(a_read_reg_107[12]),
        .I2(ap_CS_fsm_state4),
        .O(p_1_in[12]));
  LUT3 #(
    .INIT(8'hAC)) 
    \result_reg_56[13]_i_1 
       (.I0(a_assign_reg_121[13]),
        .I1(a_read_reg_107[13]),
        .I2(ap_CS_fsm_state4),
        .O(p_1_in[13]));
  LUT3 #(
    .INIT(8'hAC)) 
    \result_reg_56[14]_i_1 
       (.I0(a_assign_reg_121[14]),
        .I1(a_read_reg_107[14]),
        .I2(ap_CS_fsm_state4),
        .O(p_1_in[14]));
  LUT3 #(
    .INIT(8'hB8)) 
    \result_reg_56[15]_i_1 
       (.I0(tmp_3_reg_115),
        .I1(ap_CS_fsm_state4),
        .I2(ap_CS_fsm_state2),
        .O(\result_reg_56[15]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hAC)) 
    \result_reg_56[15]_i_2 
       (.I0(a_assign_reg_121[15]),
        .I1(a_read_reg_107[15]),
        .I2(ap_CS_fsm_state4),
        .O(p_1_in[15]));
  LUT3 #(
    .INIT(8'hAC)) 
    \result_reg_56[1]_i_1 
       (.I0(a_assign_reg_121[1]),
        .I1(a_read_reg_107[1]),
        .I2(ap_CS_fsm_state4),
        .O(p_1_in[1]));
  LUT3 #(
    .INIT(8'hAC)) 
    \result_reg_56[2]_i_1 
       (.I0(a_assign_reg_121[2]),
        .I1(a_read_reg_107[2]),
        .I2(ap_CS_fsm_state4),
        .O(p_1_in[2]));
  LUT3 #(
    .INIT(8'hAC)) 
    \result_reg_56[3]_i_1 
       (.I0(a_assign_reg_121[3]),
        .I1(a_read_reg_107[3]),
        .I2(ap_CS_fsm_state4),
        .O(p_1_in[3]));
  LUT3 #(
    .INIT(8'hAC)) 
    \result_reg_56[4]_i_1 
       (.I0(a_assign_reg_121[4]),
        .I1(a_read_reg_107[4]),
        .I2(ap_CS_fsm_state4),
        .O(p_1_in[4]));
  LUT3 #(
    .INIT(8'hAC)) 
    \result_reg_56[5]_i_1 
       (.I0(a_assign_reg_121[5]),
        .I1(a_read_reg_107[5]),
        .I2(ap_CS_fsm_state4),
        .O(p_1_in[5]));
  LUT3 #(
    .INIT(8'hAC)) 
    \result_reg_56[6]_i_1 
       (.I0(a_assign_reg_121[6]),
        .I1(a_read_reg_107[6]),
        .I2(ap_CS_fsm_state4),
        .O(p_1_in[6]));
  LUT3 #(
    .INIT(8'hAC)) 
    \result_reg_56[7]_i_1 
       (.I0(a_assign_reg_121[7]),
        .I1(a_read_reg_107[7]),
        .I2(ap_CS_fsm_state4),
        .O(p_1_in[7]));
  LUT3 #(
    .INIT(8'hAC)) 
    \result_reg_56[8]_i_1 
       (.I0(a_assign_reg_121[8]),
        .I1(a_read_reg_107[8]),
        .I2(ap_CS_fsm_state4),
        .O(p_1_in[8]));
  LUT3 #(
    .INIT(8'hAC)) 
    \result_reg_56[9]_i_1 
       (.I0(a_assign_reg_121[9]),
        .I1(a_read_reg_107[9]),
        .I2(ap_CS_fsm_state4),
        .O(p_1_in[9]));
  FDRE \result_reg_56_reg[0] 
       (.C(ap_clk),
        .CE(\result_reg_56[15]_i_1_n_0 ),
        .D(p_1_in[0]),
        .Q(result_reg_56[0]),
        .R(1'b0));
  FDRE \result_reg_56_reg[10] 
       (.C(ap_clk),
        .CE(\result_reg_56[15]_i_1_n_0 ),
        .D(p_1_in[10]),
        .Q(result_reg_56[10]),
        .R(1'b0));
  FDRE \result_reg_56_reg[11] 
       (.C(ap_clk),
        .CE(\result_reg_56[15]_i_1_n_0 ),
        .D(p_1_in[11]),
        .Q(result_reg_56[11]),
        .R(1'b0));
  FDRE \result_reg_56_reg[12] 
       (.C(ap_clk),
        .CE(\result_reg_56[15]_i_1_n_0 ),
        .D(p_1_in[12]),
        .Q(result_reg_56[12]),
        .R(1'b0));
  FDRE \result_reg_56_reg[13] 
       (.C(ap_clk),
        .CE(\result_reg_56[15]_i_1_n_0 ),
        .D(p_1_in[13]),
        .Q(result_reg_56[13]),
        .R(1'b0));
  FDRE \result_reg_56_reg[14] 
       (.C(ap_clk),
        .CE(\result_reg_56[15]_i_1_n_0 ),
        .D(p_1_in[14]),
        .Q(result_reg_56[14]),
        .R(1'b0));
  FDRE \result_reg_56_reg[15] 
       (.C(ap_clk),
        .CE(\result_reg_56[15]_i_1_n_0 ),
        .D(p_1_in[15]),
        .Q(result_reg_56[15]),
        .R(1'b0));
  FDRE \result_reg_56_reg[1] 
       (.C(ap_clk),
        .CE(\result_reg_56[15]_i_1_n_0 ),
        .D(p_1_in[1]),
        .Q(result_reg_56[1]),
        .R(1'b0));
  FDRE \result_reg_56_reg[2] 
       (.C(ap_clk),
        .CE(\result_reg_56[15]_i_1_n_0 ),
        .D(p_1_in[2]),
        .Q(result_reg_56[2]),
        .R(1'b0));
  FDRE \result_reg_56_reg[3] 
       (.C(ap_clk),
        .CE(\result_reg_56[15]_i_1_n_0 ),
        .D(p_1_in[3]),
        .Q(result_reg_56[3]),
        .R(1'b0));
  FDRE \result_reg_56_reg[4] 
       (.C(ap_clk),
        .CE(\result_reg_56[15]_i_1_n_0 ),
        .D(p_1_in[4]),
        .Q(result_reg_56[4]),
        .R(1'b0));
  FDRE \result_reg_56_reg[5] 
       (.C(ap_clk),
        .CE(\result_reg_56[15]_i_1_n_0 ),
        .D(p_1_in[5]),
        .Q(result_reg_56[5]),
        .R(1'b0));
  FDRE \result_reg_56_reg[6] 
       (.C(ap_clk),
        .CE(\result_reg_56[15]_i_1_n_0 ),
        .D(p_1_in[6]),
        .Q(result_reg_56[6]),
        .R(1'b0));
  FDRE \result_reg_56_reg[7] 
       (.C(ap_clk),
        .CE(\result_reg_56[15]_i_1_n_0 ),
        .D(p_1_in[7]),
        .Q(result_reg_56[7]),
        .R(1'b0));
  FDRE \result_reg_56_reg[8] 
       (.C(ap_clk),
        .CE(\result_reg_56[15]_i_1_n_0 ),
        .D(p_1_in[8]),
        .Q(result_reg_56[8]),
        .R(1'b0));
  FDRE \result_reg_56_reg[9] 
       (.C(ap_clk),
        .CE(\result_reg_56[15]_i_1_n_0 ),
        .D(p_1_in[9]),
        .Q(result_reg_56[9]),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h9009)) 
    \tmp_3_reg_115[0]_i_10 
       (.I0(result_reg_56[8]),
        .I1(p_s_reg_45[8]),
        .I2(result_reg_56[9]),
        .I3(p_s_reg_45[9]),
        .O(\tmp_3_reg_115[0]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \tmp_3_reg_115[0]_i_11 
       (.I0(result_reg_56[6]),
        .I1(p_s_reg_45[6]),
        .I2(p_s_reg_45[7]),
        .I3(result_reg_56[7]),
        .O(\tmp_3_reg_115[0]_i_11_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \tmp_3_reg_115[0]_i_12 
       (.I0(result_reg_56[4]),
        .I1(p_s_reg_45[4]),
        .I2(p_s_reg_45[5]),
        .I3(result_reg_56[5]),
        .O(\tmp_3_reg_115[0]_i_12_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \tmp_3_reg_115[0]_i_13 
       (.I0(result_reg_56[2]),
        .I1(p_s_reg_45[2]),
        .I2(p_s_reg_45[3]),
        .I3(result_reg_56[3]),
        .O(\tmp_3_reg_115[0]_i_13_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \tmp_3_reg_115[0]_i_14 
       (.I0(result_reg_56[0]),
        .I1(p_s_reg_45[0]),
        .I2(p_s_reg_45[1]),
        .I3(result_reg_56[1]),
        .O(\tmp_3_reg_115[0]_i_14_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \tmp_3_reg_115[0]_i_15 
       (.I0(result_reg_56[6]),
        .I1(p_s_reg_45[6]),
        .I2(result_reg_56[7]),
        .I3(p_s_reg_45[7]),
        .O(\tmp_3_reg_115[0]_i_15_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \tmp_3_reg_115[0]_i_16 
       (.I0(result_reg_56[4]),
        .I1(p_s_reg_45[4]),
        .I2(result_reg_56[5]),
        .I3(p_s_reg_45[5]),
        .O(\tmp_3_reg_115[0]_i_16_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \tmp_3_reg_115[0]_i_17 
       (.I0(result_reg_56[2]),
        .I1(p_s_reg_45[2]),
        .I2(result_reg_56[3]),
        .I3(p_s_reg_45[3]),
        .O(\tmp_3_reg_115[0]_i_17_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \tmp_3_reg_115[0]_i_18 
       (.I0(result_reg_56[0]),
        .I1(p_s_reg_45[0]),
        .I2(result_reg_56[1]),
        .I3(p_s_reg_45[1]),
        .O(\tmp_3_reg_115[0]_i_18_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \tmp_3_reg_115[0]_i_3 
       (.I0(result_reg_56[14]),
        .I1(p_s_reg_45[14]),
        .I2(result_reg_56[15]),
        .I3(p_s_reg_45[15]),
        .O(\tmp_3_reg_115[0]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \tmp_3_reg_115[0]_i_4 
       (.I0(result_reg_56[12]),
        .I1(p_s_reg_45[12]),
        .I2(p_s_reg_45[13]),
        .I3(result_reg_56[13]),
        .O(\tmp_3_reg_115[0]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \tmp_3_reg_115[0]_i_5 
       (.I0(result_reg_56[10]),
        .I1(p_s_reg_45[10]),
        .I2(p_s_reg_45[11]),
        .I3(result_reg_56[11]),
        .O(\tmp_3_reg_115[0]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \tmp_3_reg_115[0]_i_6 
       (.I0(result_reg_56[8]),
        .I1(p_s_reg_45[8]),
        .I2(p_s_reg_45[9]),
        .I3(result_reg_56[9]),
        .O(\tmp_3_reg_115[0]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \tmp_3_reg_115[0]_i_7 
       (.I0(result_reg_56[14]),
        .I1(p_s_reg_45[14]),
        .I2(p_s_reg_45[15]),
        .I3(result_reg_56[15]),
        .O(\tmp_3_reg_115[0]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \tmp_3_reg_115[0]_i_8 
       (.I0(result_reg_56[12]),
        .I1(p_s_reg_45[12]),
        .I2(result_reg_56[13]),
        .I3(p_s_reg_45[13]),
        .O(\tmp_3_reg_115[0]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \tmp_3_reg_115[0]_i_9 
       (.I0(result_reg_56[10]),
        .I1(p_s_reg_45[10]),
        .I2(result_reg_56[11]),
        .I3(p_s_reg_45[11]),
        .O(\tmp_3_reg_115[0]_i_9_n_0 ));
  FDRE \tmp_3_reg_115_reg[0] 
       (.C(ap_clk),
        .CE(a_assign_reg_1210),
        .D(tmp_3_fu_72_p2),
        .Q(tmp_3_reg_115),
        .R(1'b0));
  CARRY4 \tmp_3_reg_115_reg[0]_i_1 
       (.CI(\tmp_3_reg_115_reg[0]_i_2_n_0 ),
        .CO({tmp_3_fu_72_p2,\tmp_3_reg_115_reg[0]_i_1_n_1 ,\tmp_3_reg_115_reg[0]_i_1_n_2 ,\tmp_3_reg_115_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\tmp_3_reg_115[0]_i_3_n_0 ,\tmp_3_reg_115[0]_i_4_n_0 ,\tmp_3_reg_115[0]_i_5_n_0 ,\tmp_3_reg_115[0]_i_6_n_0 }),
        .O(\NLW_tmp_3_reg_115_reg[0]_i_1_O_UNCONNECTED [3:0]),
        .S({\tmp_3_reg_115[0]_i_7_n_0 ,\tmp_3_reg_115[0]_i_8_n_0 ,\tmp_3_reg_115[0]_i_9_n_0 ,\tmp_3_reg_115[0]_i_10_n_0 }));
  CARRY4 \tmp_3_reg_115_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\tmp_3_reg_115_reg[0]_i_2_n_0 ,\tmp_3_reg_115_reg[0]_i_2_n_1 ,\tmp_3_reg_115_reg[0]_i_2_n_2 ,\tmp_3_reg_115_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({\tmp_3_reg_115[0]_i_11_n_0 ,\tmp_3_reg_115[0]_i_12_n_0 ,\tmp_3_reg_115[0]_i_13_n_0 ,\tmp_3_reg_115[0]_i_14_n_0 }),
        .O(\NLW_tmp_3_reg_115_reg[0]_i_2_O_UNCONNECTED [3:0]),
        .S({\tmp_3_reg_115[0]_i_15_n_0 ,\tmp_3_reg_115[0]_i_16_n_0 ,\tmp_3_reg_115[0]_i_17_n_0 ,\tmp_3_reg_115[0]_i_18_n_0 }));
endmodule

(* ORIG_REF_NAME = "gcd_gcd_bus_s_axi" *) 
module gcd_block_design_gcd_0_1_gcd_gcd_bus_s_axi
   (out,
    s_axi_gcd_bus_RVALID,
    SR,
    interrupt,
    D,
    CO,
    E,
    \b_read_reg_102_reg[15] ,
    \a_read_reg_107_reg[15] ,
    s_axi_gcd_bus_RDATA,
    ap_clk,
    s_axi_gcd_bus_ARVALID,
    s_axi_gcd_bus_RREADY,
    s_axi_gcd_bus_AWVALID,
    s_axi_gcd_bus_WVALID,
    s_axi_gcd_bus_WDATA,
    s_axi_gcd_bus_WSTRB,
    s_axi_gcd_bus_BREADY,
    Q,
    \result_reg_56_reg[15] ,
    \p_s_reg_45_reg[15] ,
    s_axi_gcd_bus_ARADDR,
    ap_rst_n,
    s_axi_gcd_bus_AWADDR);
  output [2:0]out;
  output [1:0]s_axi_gcd_bus_RVALID;
  output [0:0]SR;
  output interrupt;
  output [1:0]D;
  output [0:0]CO;
  output [0:0]E;
  output [15:0]\b_read_reg_102_reg[15] ;
  output [15:0]\a_read_reg_107_reg[15] ;
  output [15:0]s_axi_gcd_bus_RDATA;
  input ap_clk;
  input s_axi_gcd_bus_ARVALID;
  input s_axi_gcd_bus_RREADY;
  input s_axi_gcd_bus_AWVALID;
  input s_axi_gcd_bus_WVALID;
  input [15:0]s_axi_gcd_bus_WDATA;
  input [1:0]s_axi_gcd_bus_WSTRB;
  input s_axi_gcd_bus_BREADY;
  input [3:0]Q;
  input [15:0]\result_reg_56_reg[15] ;
  input [15:0]\p_s_reg_45_reg[15] ;
  input [5:0]s_axi_gcd_bus_ARADDR;
  input ap_rst_n;
  input [5:0]s_axi_gcd_bus_AWADDR;

  wire [0:0]CO;
  wire [1:0]D;
  wire [0:0]E;
  wire \FSM_onehot_rstate[1]_i_1_n_0 ;
  wire \FSM_onehot_rstate[2]_i_1_n_0 ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_rstate_reg_n_0_[0] ;
  wire \FSM_onehot_wstate[1]_i_1_n_0 ;
  wire \FSM_onehot_wstate[2]_i_1_n_0 ;
  wire \FSM_onehot_wstate[3]_i_2_n_0 ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_wstate_reg_n_0_[0] ;
  wire [3:0]Q;
  wire [0:0]SR;
  wire [15:0]\a_read_reg_107_reg[15] ;
  wire ap_clk;
  wire ap_done;
  wire ap_idle;
  wire ap_rst_n;
  wire ap_start;
  wire ar_hs;
  wire [15:0]\b_read_reg_102_reg[15] ;
  wire [15:0]int_a0;
  wire \int_a[15]_i_1_n_0 ;
  wire \int_a[15]_i_3_n_0 ;
  wire int_ap_done;
  wire int_ap_done1;
  wire int_ap_done_i_1_n_0;
  wire int_ap_idle;
  wire int_ap_ready;
  wire int_ap_start3_out;
  wire int_ap_start_i_10_n_0;
  wire int_ap_start_i_1_n_0;
  wire int_ap_start_i_5_n_0;
  wire int_ap_start_i_6_n_0;
  wire int_ap_start_i_7_n_0;
  wire int_ap_start_i_8_n_0;
  wire int_ap_start_i_9_n_0;
  wire int_ap_start_reg_i_2_n_3;
  wire int_ap_start_reg_i_4_n_0;
  wire int_ap_start_reg_i_4_n_1;
  wire int_ap_start_reg_i_4_n_2;
  wire int_ap_start_reg_i_4_n_3;
  wire int_auto_restart;
  wire int_auto_restart_i_1_n_0;
  wire [15:0]int_b0;
  wire \int_b[15]_i_1_n_0 ;
  wire int_gie_i_1_n_0;
  wire int_gie_reg_n_0;
  wire \int_ier[0]_i_1_n_0 ;
  wire \int_ier[1]_i_1_n_0 ;
  wire \int_ier[1]_i_2_n_0 ;
  wire \int_ier_reg_n_0_[0] ;
  wire \int_ier_reg_n_0_[1] ;
  wire int_isr6_out;
  wire \int_isr[0]_i_1_n_0 ;
  wire \int_isr[1]_i_1_n_0 ;
  wire \int_isr_reg_n_0_[0] ;
  wire [15:0]int_pResult;
  wire int_pResult_ap_vld;
  wire int_pResult_ap_vld1;
  wire int_pResult_ap_vld_i_1_n_0;
  wire interrupt;
  (* RTL_KEEP = "yes" *) wire [2:0]out;
  wire p_1_in;
  wire [15:0]\p_s_reg_45_reg[15] ;
  wire \rdata[0]_i_1_n_0 ;
  wire \rdata[0]_i_2_n_0 ;
  wire \rdata[0]_i_3_n_0 ;
  wire \rdata[0]_i_4_n_0 ;
  wire \rdata[10]_i_1_n_0 ;
  wire \rdata[11]_i_1_n_0 ;
  wire \rdata[12]_i_1_n_0 ;
  wire \rdata[13]_i_1_n_0 ;
  wire \rdata[14]_i_1_n_0 ;
  wire \rdata[15]_i_1_n_0 ;
  wire \rdata[15]_i_3_n_0 ;
  wire \rdata[1]_i_1_n_0 ;
  wire \rdata[1]_i_2_n_0 ;
  wire \rdata[1]_i_3_n_0 ;
  wire \rdata[1]_i_4_n_0 ;
  wire \rdata[1]_i_5_n_0 ;
  wire \rdata[2]_i_1_n_0 ;
  wire \rdata[2]_i_2_n_0 ;
  wire \rdata[3]_i_1_n_0 ;
  wire \rdata[3]_i_2_n_0 ;
  wire \rdata[4]_i_1_n_0 ;
  wire \rdata[5]_i_1_n_0 ;
  wire \rdata[6]_i_1_n_0 ;
  wire \rdata[7]_i_1_n_0 ;
  wire \rdata[7]_i_2_n_0 ;
  wire \rdata[8]_i_1_n_0 ;
  wire \rdata[9]_i_1_n_0 ;
  wire [15:0]\result_reg_56_reg[15] ;
  wire [5:0]s_axi_gcd_bus_ARADDR;
  wire s_axi_gcd_bus_ARVALID;
  wire [5:0]s_axi_gcd_bus_AWADDR;
  wire s_axi_gcd_bus_AWVALID;
  wire s_axi_gcd_bus_BREADY;
  wire [15:0]s_axi_gcd_bus_RDATA;
  wire s_axi_gcd_bus_RREADY;
  (* RTL_KEEP = "yes" *) wire [1:0]s_axi_gcd_bus_RVALID;
  wire [15:0]s_axi_gcd_bus_WDATA;
  wire [1:0]s_axi_gcd_bus_WSTRB;
  wire s_axi_gcd_bus_WVALID;
  wire waddr;
  wire \waddr_reg_n_0_[0] ;
  wire \waddr_reg_n_0_[1] ;
  wire \waddr_reg_n_0_[2] ;
  wire \waddr_reg_n_0_[3] ;
  wire \waddr_reg_n_0_[4] ;
  wire \waddr_reg_n_0_[5] ;
  wire [3:2]NLW_int_ap_start_reg_i_2_CO_UNCONNECTED;
  wire [3:0]NLW_int_ap_start_reg_i_2_O_UNCONNECTED;
  wire [3:0]NLW_int_ap_start_reg_i_4_O_UNCONNECTED;

  LUT4 #(
    .INIT(16'hF747)) 
    \FSM_onehot_rstate[1]_i_1 
       (.I0(s_axi_gcd_bus_ARVALID),
        .I1(s_axi_gcd_bus_RVALID[0]),
        .I2(s_axi_gcd_bus_RVALID[1]),
        .I3(s_axi_gcd_bus_RREADY),
        .O(\FSM_onehot_rstate[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h88F8)) 
    \FSM_onehot_rstate[2]_i_1 
       (.I0(s_axi_gcd_bus_ARVALID),
        .I1(s_axi_gcd_bus_RVALID[0]),
        .I2(s_axi_gcd_bus_RVALID[1]),
        .I3(s_axi_gcd_bus_RREADY),
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
        .Q(s_axi_gcd_bus_RVALID[0]),
        .R(SR));
  (* FSM_ENCODED_STATES = "RDIDLE:010,RDDATA:100,iSTATE:001" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_rstate_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_rstate[2]_i_1_n_0 ),
        .Q(s_axi_gcd_bus_RVALID[1]),
        .R(SR));
  LUT5 #(
    .INIT(32'h888BFF8B)) 
    \FSM_onehot_wstate[1]_i_1 
       (.I0(s_axi_gcd_bus_BREADY),
        .I1(out[2]),
        .I2(out[1]),
        .I3(out[0]),
        .I4(s_axi_gcd_bus_AWVALID),
        .O(\FSM_onehot_wstate[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h8F88)) 
    \FSM_onehot_wstate[2]_i_1 
       (.I0(s_axi_gcd_bus_AWVALID),
        .I1(out[0]),
        .I2(s_axi_gcd_bus_WVALID),
        .I3(out[1]),
        .O(\FSM_onehot_wstate[2]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \FSM_onehot_wstate[3]_i_1 
       (.I0(ap_rst_n),
        .O(SR));
  LUT4 #(
    .INIT(16'h8F88)) 
    \FSM_onehot_wstate[3]_i_2 
       (.I0(s_axi_gcd_bus_WVALID),
        .I1(out[1]),
        .I2(s_axi_gcd_bus_BREADY),
        .I3(out[2]),
        .O(\FSM_onehot_wstate[3]_i_2_n_0 ));
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
        .D(\FSM_onehot_wstate[3]_i_2_n_0 ),
        .Q(out[2]),
        .R(SR));
  LUT4 #(
    .INIT(16'hFA30)) 
    \ap_CS_fsm[0]_i_1 
       (.I0(CO),
        .I1(ap_start),
        .I2(Q[0]),
        .I3(Q[2]),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h00001000)) 
    \ap_CS_fsm[1]_i_1 
       (.I0(Q[1]),
        .I1(Q[3]),
        .I2(Q[0]),
        .I3(ap_start),
        .I4(Q[2]),
        .O(D[1]));
  LUT2 #(
    .INIT(4'h8)) 
    \b_read_reg_102[15]_i_1 
       (.I0(Q[0]),
        .I1(ap_start),
        .O(E));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_a[0]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[0]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\a_read_reg_107_reg[15] [0]),
        .O(int_a0[0]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_a[10]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[10]),
        .I1(s_axi_gcd_bus_WSTRB[1]),
        .I2(\a_read_reg_107_reg[15] [10]),
        .O(int_a0[10]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_a[11]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[11]),
        .I1(s_axi_gcd_bus_WSTRB[1]),
        .I2(\a_read_reg_107_reg[15] [11]),
        .O(int_a0[11]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_a[12]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[12]),
        .I1(s_axi_gcd_bus_WSTRB[1]),
        .I2(\a_read_reg_107_reg[15] [12]),
        .O(int_a0[12]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_a[13]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[13]),
        .I1(s_axi_gcd_bus_WSTRB[1]),
        .I2(\a_read_reg_107_reg[15] [13]),
        .O(int_a0[13]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_a[14]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[14]),
        .I1(s_axi_gcd_bus_WSTRB[1]),
        .I2(\a_read_reg_107_reg[15] [14]),
        .O(int_a0[14]));
  LUT4 #(
    .INIT(16'h0008)) 
    \int_a[15]_i_1 
       (.I0(\waddr_reg_n_0_[4] ),
        .I1(\int_a[15]_i_3_n_0 ),
        .I2(\waddr_reg_n_0_[2] ),
        .I3(\waddr_reg_n_0_[3] ),
        .O(\int_a[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_a[15]_i_2 
       (.I0(s_axi_gcd_bus_WDATA[15]),
        .I1(s_axi_gcd_bus_WSTRB[1]),
        .I2(\a_read_reg_107_reg[15] [15]),
        .O(int_a0[15]));
  LUT5 #(
    .INIT(32'h00001000)) 
    \int_a[15]_i_3 
       (.I0(\waddr_reg_n_0_[0] ),
        .I1(\waddr_reg_n_0_[5] ),
        .I2(out[1]),
        .I3(s_axi_gcd_bus_WVALID),
        .I4(\waddr_reg_n_0_[1] ),
        .O(\int_a[15]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_a[1]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[1]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\a_read_reg_107_reg[15] [1]),
        .O(int_a0[1]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_a[2]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[2]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\a_read_reg_107_reg[15] [2]),
        .O(int_a0[2]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_a[3]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[3]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\a_read_reg_107_reg[15] [3]),
        .O(int_a0[3]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_a[4]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[4]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\a_read_reg_107_reg[15] [4]),
        .O(int_a0[4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_a[5]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[5]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\a_read_reg_107_reg[15] [5]),
        .O(int_a0[5]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_a[6]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[6]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\a_read_reg_107_reg[15] [6]),
        .O(int_a0[6]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_a[7]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[7]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\a_read_reg_107_reg[15] [7]),
        .O(int_a0[7]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_a[8]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[8]),
        .I1(s_axi_gcd_bus_WSTRB[1]),
        .I2(\a_read_reg_107_reg[15] [8]),
        .O(int_a0[8]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_a[9]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[9]),
        .I1(s_axi_gcd_bus_WSTRB[1]),
        .I2(\a_read_reg_107_reg[15] [9]),
        .O(int_a0[9]));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[0] 
       (.C(ap_clk),
        .CE(\int_a[15]_i_1_n_0 ),
        .D(int_a0[0]),
        .Q(\a_read_reg_107_reg[15] [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[10] 
       (.C(ap_clk),
        .CE(\int_a[15]_i_1_n_0 ),
        .D(int_a0[10]),
        .Q(\a_read_reg_107_reg[15] [10]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[11] 
       (.C(ap_clk),
        .CE(\int_a[15]_i_1_n_0 ),
        .D(int_a0[11]),
        .Q(\a_read_reg_107_reg[15] [11]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[12] 
       (.C(ap_clk),
        .CE(\int_a[15]_i_1_n_0 ),
        .D(int_a0[12]),
        .Q(\a_read_reg_107_reg[15] [12]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[13] 
       (.C(ap_clk),
        .CE(\int_a[15]_i_1_n_0 ),
        .D(int_a0[13]),
        .Q(\a_read_reg_107_reg[15] [13]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[14] 
       (.C(ap_clk),
        .CE(\int_a[15]_i_1_n_0 ),
        .D(int_a0[14]),
        .Q(\a_read_reg_107_reg[15] [14]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[15] 
       (.C(ap_clk),
        .CE(\int_a[15]_i_1_n_0 ),
        .D(int_a0[15]),
        .Q(\a_read_reg_107_reg[15] [15]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[1] 
       (.C(ap_clk),
        .CE(\int_a[15]_i_1_n_0 ),
        .D(int_a0[1]),
        .Q(\a_read_reg_107_reg[15] [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[2] 
       (.C(ap_clk),
        .CE(\int_a[15]_i_1_n_0 ),
        .D(int_a0[2]),
        .Q(\a_read_reg_107_reg[15] [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[3] 
       (.C(ap_clk),
        .CE(\int_a[15]_i_1_n_0 ),
        .D(int_a0[3]),
        .Q(\a_read_reg_107_reg[15] [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[4] 
       (.C(ap_clk),
        .CE(\int_a[15]_i_1_n_0 ),
        .D(int_a0[4]),
        .Q(\a_read_reg_107_reg[15] [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[5] 
       (.C(ap_clk),
        .CE(\int_a[15]_i_1_n_0 ),
        .D(int_a0[5]),
        .Q(\a_read_reg_107_reg[15] [5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[6] 
       (.C(ap_clk),
        .CE(\int_a[15]_i_1_n_0 ),
        .D(int_a0[6]),
        .Q(\a_read_reg_107_reg[15] [6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[7] 
       (.C(ap_clk),
        .CE(\int_a[15]_i_1_n_0 ),
        .D(int_a0[7]),
        .Q(\a_read_reg_107_reg[15] [7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[8] 
       (.C(ap_clk),
        .CE(\int_a[15]_i_1_n_0 ),
        .D(int_a0[8]),
        .Q(\a_read_reg_107_reg[15] [8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[9] 
       (.C(ap_clk),
        .CE(\int_a[15]_i_1_n_0 ),
        .D(int_a0[9]),
        .Q(\a_read_reg_107_reg[15] [9]),
        .R(SR));
  LUT6 #(
    .INIT(64'h8FFFFFFF88888888)) 
    int_ap_done_i_1
       (.I0(Q[2]),
        .I1(CO),
        .I2(s_axi_gcd_bus_RVALID[0]),
        .I3(s_axi_gcd_bus_ARVALID),
        .I4(int_ap_done1),
        .I5(int_ap_done),
        .O(int_ap_done_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    int_ap_done_i_2
       (.I0(s_axi_gcd_bus_ARADDR[5]),
        .I1(s_axi_gcd_bus_ARADDR[4]),
        .I2(s_axi_gcd_bus_ARADDR[1]),
        .I3(s_axi_gcd_bus_ARADDR[0]),
        .I4(s_axi_gcd_bus_ARADDR[3]),
        .I5(s_axi_gcd_bus_ARADDR[2]),
        .O(int_ap_done1));
  FDRE #(
    .INIT(1'b0)) 
    int_ap_done_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(int_ap_done_i_1_n_0),
        .Q(int_ap_done),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h2)) 
    int_ap_idle_i_1
       (.I0(Q[0]),
        .I1(ap_start),
        .O(ap_idle));
  FDRE int_ap_idle_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_idle),
        .Q(int_ap_idle),
        .R(SR));
  LUT2 #(
    .INIT(4'h8)) 
    int_ap_ready_i_1
       (.I0(CO),
        .I1(Q[2]),
        .O(ap_done));
  FDRE int_ap_ready_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_done),
        .Q(int_ap_ready),
        .R(SR));
  LUT5 #(
    .INIT(32'hFFBFFF80)) 
    int_ap_start_i_1
       (.I0(int_auto_restart),
        .I1(Q[2]),
        .I2(CO),
        .I3(int_ap_start3_out),
        .I4(ap_start),
        .O(int_ap_start_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    int_ap_start_i_10
       (.I0(\result_reg_56_reg[15] [0]),
        .I1(\p_s_reg_45_reg[15] [0]),
        .I2(\p_s_reg_45_reg[15] [2]),
        .I3(\result_reg_56_reg[15] [2]),
        .I4(\p_s_reg_45_reg[15] [1]),
        .I5(\result_reg_56_reg[15] [1]),
        .O(int_ap_start_i_10_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00000800)) 
    int_ap_start_i_3
       (.I0(s_axi_gcd_bus_WDATA[0]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\waddr_reg_n_0_[2] ),
        .I3(\int_ier[1]_i_2_n_0 ),
        .I4(\waddr_reg_n_0_[3] ),
        .O(int_ap_start3_out));
  LUT2 #(
    .INIT(4'h9)) 
    int_ap_start_i_5
       (.I0(\p_s_reg_45_reg[15] [15]),
        .I1(\result_reg_56_reg[15] [15]),
        .O(int_ap_start_i_5_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    int_ap_start_i_6
       (.I0(\result_reg_56_reg[15] [12]),
        .I1(\p_s_reg_45_reg[15] [12]),
        .I2(\p_s_reg_45_reg[15] [14]),
        .I3(\result_reg_56_reg[15] [14]),
        .I4(\p_s_reg_45_reg[15] [13]),
        .I5(\result_reg_56_reg[15] [13]),
        .O(int_ap_start_i_6_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    int_ap_start_i_7
       (.I0(\result_reg_56_reg[15] [9]),
        .I1(\p_s_reg_45_reg[15] [9]),
        .I2(\p_s_reg_45_reg[15] [11]),
        .I3(\result_reg_56_reg[15] [11]),
        .I4(\p_s_reg_45_reg[15] [10]),
        .I5(\result_reg_56_reg[15] [10]),
        .O(int_ap_start_i_7_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    int_ap_start_i_8
       (.I0(\result_reg_56_reg[15] [6]),
        .I1(\p_s_reg_45_reg[15] [6]),
        .I2(\p_s_reg_45_reg[15] [8]),
        .I3(\result_reg_56_reg[15] [8]),
        .I4(\p_s_reg_45_reg[15] [7]),
        .I5(\result_reg_56_reg[15] [7]),
        .O(int_ap_start_i_8_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    int_ap_start_i_9
       (.I0(\result_reg_56_reg[15] [3]),
        .I1(\p_s_reg_45_reg[15] [3]),
        .I2(\p_s_reg_45_reg[15] [5]),
        .I3(\result_reg_56_reg[15] [5]),
        .I4(\p_s_reg_45_reg[15] [4]),
        .I5(\result_reg_56_reg[15] [4]),
        .O(int_ap_start_i_9_n_0));
  FDRE #(
    .INIT(1'b0)) 
    int_ap_start_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(int_ap_start_i_1_n_0),
        .Q(ap_start),
        .R(SR));
  CARRY4 int_ap_start_reg_i_2
       (.CI(int_ap_start_reg_i_4_n_0),
        .CO({NLW_int_ap_start_reg_i_2_CO_UNCONNECTED[3:2],CO,int_ap_start_reg_i_2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_int_ap_start_reg_i_2_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,int_ap_start_i_5_n_0,int_ap_start_i_6_n_0}));
  CARRY4 int_ap_start_reg_i_4
       (.CI(1'b0),
        .CO({int_ap_start_reg_i_4_n_0,int_ap_start_reg_i_4_n_1,int_ap_start_reg_i_4_n_2,int_ap_start_reg_i_4_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_int_ap_start_reg_i_4_O_UNCONNECTED[3:0]),
        .S({int_ap_start_i_7_n_0,int_ap_start_i_8_n_0,int_ap_start_i_9_n_0,int_ap_start_i_10_n_0}));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    int_auto_restart_i_1
       (.I0(s_axi_gcd_bus_WDATA[7]),
        .I1(\waddr_reg_n_0_[3] ),
        .I2(\int_ier[1]_i_2_n_0 ),
        .I3(\waddr_reg_n_0_[2] ),
        .I4(s_axi_gcd_bus_WSTRB[0]),
        .I5(int_auto_restart),
        .O(int_auto_restart_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    int_auto_restart_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(int_auto_restart_i_1_n_0),
        .Q(int_auto_restart),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_b[0]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[0]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\b_read_reg_102_reg[15] [0]),
        .O(int_b0[0]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_b[10]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[10]),
        .I1(s_axi_gcd_bus_WSTRB[1]),
        .I2(\b_read_reg_102_reg[15] [10]),
        .O(int_b0[10]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_b[11]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[11]),
        .I1(s_axi_gcd_bus_WSTRB[1]),
        .I2(\b_read_reg_102_reg[15] [11]),
        .O(int_b0[11]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_b[12]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[12]),
        .I1(s_axi_gcd_bus_WSTRB[1]),
        .I2(\b_read_reg_102_reg[15] [12]),
        .O(int_b0[12]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_b[13]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[13]),
        .I1(s_axi_gcd_bus_WSTRB[1]),
        .I2(\b_read_reg_102_reg[15] [13]),
        .O(int_b0[13]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_b[14]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[14]),
        .I1(s_axi_gcd_bus_WSTRB[1]),
        .I2(\b_read_reg_102_reg[15] [14]),
        .O(int_b0[14]));
  LUT4 #(
    .INIT(16'h0080)) 
    \int_b[15]_i_1 
       (.I0(\waddr_reg_n_0_[3] ),
        .I1(\waddr_reg_n_0_[4] ),
        .I2(\int_a[15]_i_3_n_0 ),
        .I3(\waddr_reg_n_0_[2] ),
        .O(\int_b[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_b[15]_i_2 
       (.I0(s_axi_gcd_bus_WDATA[15]),
        .I1(s_axi_gcd_bus_WSTRB[1]),
        .I2(\b_read_reg_102_reg[15] [15]),
        .O(int_b0[15]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_b[1]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[1]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\b_read_reg_102_reg[15] [1]),
        .O(int_b0[1]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_b[2]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[2]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\b_read_reg_102_reg[15] [2]),
        .O(int_b0[2]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_b[3]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[3]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\b_read_reg_102_reg[15] [3]),
        .O(int_b0[3]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_b[4]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[4]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\b_read_reg_102_reg[15] [4]),
        .O(int_b0[4]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_b[5]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[5]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\b_read_reg_102_reg[15] [5]),
        .O(int_b0[5]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_b[6]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[6]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\b_read_reg_102_reg[15] [6]),
        .O(int_b0[6]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_b[7]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[7]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\b_read_reg_102_reg[15] [7]),
        .O(int_b0[7]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_b[8]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[8]),
        .I1(s_axi_gcd_bus_WSTRB[1]),
        .I2(\b_read_reg_102_reg[15] [8]),
        .O(int_b0[8]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_b[9]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[9]),
        .I1(s_axi_gcd_bus_WSTRB[1]),
        .I2(\b_read_reg_102_reg[15] [9]),
        .O(int_b0[9]));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[0] 
       (.C(ap_clk),
        .CE(\int_b[15]_i_1_n_0 ),
        .D(int_b0[0]),
        .Q(\b_read_reg_102_reg[15] [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[10] 
       (.C(ap_clk),
        .CE(\int_b[15]_i_1_n_0 ),
        .D(int_b0[10]),
        .Q(\b_read_reg_102_reg[15] [10]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[11] 
       (.C(ap_clk),
        .CE(\int_b[15]_i_1_n_0 ),
        .D(int_b0[11]),
        .Q(\b_read_reg_102_reg[15] [11]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[12] 
       (.C(ap_clk),
        .CE(\int_b[15]_i_1_n_0 ),
        .D(int_b0[12]),
        .Q(\b_read_reg_102_reg[15] [12]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[13] 
       (.C(ap_clk),
        .CE(\int_b[15]_i_1_n_0 ),
        .D(int_b0[13]),
        .Q(\b_read_reg_102_reg[15] [13]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[14] 
       (.C(ap_clk),
        .CE(\int_b[15]_i_1_n_0 ),
        .D(int_b0[14]),
        .Q(\b_read_reg_102_reg[15] [14]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[15] 
       (.C(ap_clk),
        .CE(\int_b[15]_i_1_n_0 ),
        .D(int_b0[15]),
        .Q(\b_read_reg_102_reg[15] [15]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[1] 
       (.C(ap_clk),
        .CE(\int_b[15]_i_1_n_0 ),
        .D(int_b0[1]),
        .Q(\b_read_reg_102_reg[15] [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[2] 
       (.C(ap_clk),
        .CE(\int_b[15]_i_1_n_0 ),
        .D(int_b0[2]),
        .Q(\b_read_reg_102_reg[15] [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[3] 
       (.C(ap_clk),
        .CE(\int_b[15]_i_1_n_0 ),
        .D(int_b0[3]),
        .Q(\b_read_reg_102_reg[15] [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[4] 
       (.C(ap_clk),
        .CE(\int_b[15]_i_1_n_0 ),
        .D(int_b0[4]),
        .Q(\b_read_reg_102_reg[15] [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[5] 
       (.C(ap_clk),
        .CE(\int_b[15]_i_1_n_0 ),
        .D(int_b0[5]),
        .Q(\b_read_reg_102_reg[15] [5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[6] 
       (.C(ap_clk),
        .CE(\int_b[15]_i_1_n_0 ),
        .D(int_b0[6]),
        .Q(\b_read_reg_102_reg[15] [6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[7] 
       (.C(ap_clk),
        .CE(\int_b[15]_i_1_n_0 ),
        .D(int_b0[7]),
        .Q(\b_read_reg_102_reg[15] [7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[8] 
       (.C(ap_clk),
        .CE(\int_b[15]_i_1_n_0 ),
        .D(int_b0[8]),
        .Q(\b_read_reg_102_reg[15] [8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[9] 
       (.C(ap_clk),
        .CE(\int_b[15]_i_1_n_0 ),
        .D(int_b0[9]),
        .Q(\b_read_reg_102_reg[15] [9]),
        .R(SR));
  LUT6 #(
    .INIT(64'hFBFFFFFF08000000)) 
    int_gie_i_1
       (.I0(s_axi_gcd_bus_WDATA[0]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\waddr_reg_n_0_[3] ),
        .I3(\waddr_reg_n_0_[2] ),
        .I4(\int_ier[1]_i_2_n_0 ),
        .I5(int_gie_reg_n_0),
        .O(int_gie_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    int_gie_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(int_gie_i_1_n_0),
        .Q(int_gie_reg_n_0),
        .R(SR));
  LUT6 #(
    .INIT(64'hFFBFFFFF00800000)) 
    \int_ier[0]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[0]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\int_ier[1]_i_2_n_0 ),
        .I3(\waddr_reg_n_0_[2] ),
        .I4(\waddr_reg_n_0_[3] ),
        .I5(\int_ier_reg_n_0_[0] ),
        .O(\int_ier[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFBFFFFF00800000)) 
    \int_ier[1]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[1]),
        .I1(s_axi_gcd_bus_WSTRB[0]),
        .I2(\int_ier[1]_i_2_n_0 ),
        .I3(\waddr_reg_n_0_[2] ),
        .I4(\waddr_reg_n_0_[3] ),
        .I5(\int_ier_reg_n_0_[1] ),
        .O(\int_ier[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000040)) 
    \int_ier[1]_i_2 
       (.I0(\waddr_reg_n_0_[1] ),
        .I1(s_axi_gcd_bus_WVALID),
        .I2(out[1]),
        .I3(\waddr_reg_n_0_[5] ),
        .I4(\waddr_reg_n_0_[0] ),
        .I5(\waddr_reg_n_0_[4] ),
        .O(\int_ier[1]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \int_ier_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\int_ier[0]_i_1_n_0 ),
        .Q(\int_ier_reg_n_0_[0] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ier_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\int_ier[1]_i_1_n_0 ),
        .Q(\int_ier_reg_n_0_[1] ),
        .R(SR));
  LUT6 #(
    .INIT(64'hF7777777F8888888)) 
    \int_isr[0]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[0]),
        .I1(int_isr6_out),
        .I2(\int_ier_reg_n_0_[0] ),
        .I3(CO),
        .I4(Q[2]),
        .I5(\int_isr_reg_n_0_[0] ),
        .O(\int_isr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \int_isr[0]_i_2 
       (.I0(s_axi_gcd_bus_WSTRB[0]),
        .I1(\waddr_reg_n_0_[2] ),
        .I2(\int_ier[1]_i_2_n_0 ),
        .I3(\waddr_reg_n_0_[3] ),
        .O(int_isr6_out));
  LUT6 #(
    .INIT(64'hF7777777F8888888)) 
    \int_isr[1]_i_1 
       (.I0(s_axi_gcd_bus_WDATA[1]),
        .I1(int_isr6_out),
        .I2(\int_ier_reg_n_0_[1] ),
        .I3(CO),
        .I4(Q[2]),
        .I5(p_1_in),
        .O(\int_isr[1]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \int_isr_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\int_isr[0]_i_1_n_0 ),
        .Q(\int_isr_reg_n_0_[0] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_isr_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\int_isr[1]_i_1_n_0 ),
        .Q(p_1_in),
        .R(SR));
  LUT6 #(
    .INIT(64'h8FFFFFFF88888888)) 
    int_pResult_ap_vld_i_1
       (.I0(Q[2]),
        .I1(CO),
        .I2(s_axi_gcd_bus_RVALID[0]),
        .I3(s_axi_gcd_bus_ARVALID),
        .I4(int_pResult_ap_vld1),
        .I5(int_pResult_ap_vld),
        .O(int_pResult_ap_vld_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000000001000)) 
    int_pResult_ap_vld_i_2
       (.I0(s_axi_gcd_bus_ARADDR[1]),
        .I1(s_axi_gcd_bus_ARADDR[4]),
        .I2(s_axi_gcd_bus_ARADDR[5]),
        .I3(s_axi_gcd_bus_ARADDR[2]),
        .I4(s_axi_gcd_bus_ARADDR[3]),
        .I5(s_axi_gcd_bus_ARADDR[0]),
        .O(int_pResult_ap_vld1));
  FDRE int_pResult_ap_vld_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(int_pResult_ap_vld_i_1_n_0),
        .Q(int_pResult_ap_vld),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_pResult_reg[0] 
       (.C(ap_clk),
        .CE(ap_done),
        .D(\p_s_reg_45_reg[15] [0]),
        .Q(int_pResult[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_pResult_reg[10] 
       (.C(ap_clk),
        .CE(ap_done),
        .D(\p_s_reg_45_reg[15] [10]),
        .Q(int_pResult[10]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_pResult_reg[11] 
       (.C(ap_clk),
        .CE(ap_done),
        .D(\p_s_reg_45_reg[15] [11]),
        .Q(int_pResult[11]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_pResult_reg[12] 
       (.C(ap_clk),
        .CE(ap_done),
        .D(\p_s_reg_45_reg[15] [12]),
        .Q(int_pResult[12]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_pResult_reg[13] 
       (.C(ap_clk),
        .CE(ap_done),
        .D(\p_s_reg_45_reg[15] [13]),
        .Q(int_pResult[13]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_pResult_reg[14] 
       (.C(ap_clk),
        .CE(ap_done),
        .D(\p_s_reg_45_reg[15] [14]),
        .Q(int_pResult[14]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_pResult_reg[15] 
       (.C(ap_clk),
        .CE(ap_done),
        .D(\p_s_reg_45_reg[15] [15]),
        .Q(int_pResult[15]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_pResult_reg[1] 
       (.C(ap_clk),
        .CE(ap_done),
        .D(\p_s_reg_45_reg[15] [1]),
        .Q(int_pResult[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_pResult_reg[2] 
       (.C(ap_clk),
        .CE(ap_done),
        .D(\p_s_reg_45_reg[15] [2]),
        .Q(int_pResult[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_pResult_reg[3] 
       (.C(ap_clk),
        .CE(ap_done),
        .D(\p_s_reg_45_reg[15] [3]),
        .Q(int_pResult[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_pResult_reg[4] 
       (.C(ap_clk),
        .CE(ap_done),
        .D(\p_s_reg_45_reg[15] [4]),
        .Q(int_pResult[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_pResult_reg[5] 
       (.C(ap_clk),
        .CE(ap_done),
        .D(\p_s_reg_45_reg[15] [5]),
        .Q(int_pResult[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_pResult_reg[6] 
       (.C(ap_clk),
        .CE(ap_done),
        .D(\p_s_reg_45_reg[15] [6]),
        .Q(int_pResult[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_pResult_reg[7] 
       (.C(ap_clk),
        .CE(ap_done),
        .D(\p_s_reg_45_reg[15] [7]),
        .Q(int_pResult[7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_pResult_reg[8] 
       (.C(ap_clk),
        .CE(ap_done),
        .D(\p_s_reg_45_reg[15] [8]),
        .Q(int_pResult[8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_pResult_reg[9] 
       (.C(ap_clk),
        .CE(ap_done),
        .D(\p_s_reg_45_reg[15] [9]),
        .Q(int_pResult[9]),
        .R(SR));
  LUT3 #(
    .INIT(8'hE0)) 
    interrupt_INST_0
       (.I0(p_1_in),
        .I1(\int_isr_reg_n_0_[0] ),
        .I2(int_gie_reg_n_0),
        .O(interrupt));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rdata[0]_i_1 
       (.I0(\rdata[0]_i_2_n_0 ),
        .I1(s_axi_gcd_bus_ARADDR[2]),
        .I2(\rdata[0]_i_3_n_0 ),
        .I3(\rdata[1]_i_4_n_0 ),
        .I4(ar_hs),
        .I5(s_axi_gcd_bus_RDATA[0]),
        .O(\rdata[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rdata[0]_i_2 
       (.I0(\int_ier_reg_n_0_[0] ),
        .I1(s_axi_gcd_bus_ARADDR[4]),
        .I2(\b_read_reg_102_reg[15] [0]),
        .I3(s_axi_gcd_bus_ARADDR[5]),
        .I4(s_axi_gcd_bus_ARADDR[3]),
        .I5(\rdata[0]_i_4_n_0 ),
        .O(\rdata[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0033223000002230)) 
    \rdata[0]_i_3 
       (.I0(int_pResult_ap_vld),
        .I1(s_axi_gcd_bus_ARADDR[4]),
        .I2(int_gie_reg_n_0),
        .I3(s_axi_gcd_bus_ARADDR[5]),
        .I4(s_axi_gcd_bus_ARADDR[3]),
        .I5(\int_isr_reg_n_0_[0] ),
        .O(\rdata[0]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \rdata[0]_i_4 
       (.I0(\a_read_reg_107_reg[15] [0]),
        .I1(s_axi_gcd_bus_ARADDR[4]),
        .I2(int_pResult[0]),
        .I3(s_axi_gcd_bus_ARADDR[5]),
        .I4(ap_start),
        .O(\rdata[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0033B8000000B800)) 
    \rdata[10]_i_1 
       (.I0(\b_read_reg_102_reg[15] [10]),
        .I1(s_axi_gcd_bus_ARADDR[3]),
        .I2(\a_read_reg_107_reg[15] [10]),
        .I3(s_axi_gcd_bus_ARADDR[4]),
        .I4(s_axi_gcd_bus_ARADDR[5]),
        .I5(int_pResult[10]),
        .O(\rdata[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0033B8000000B800)) 
    \rdata[11]_i_1 
       (.I0(\b_read_reg_102_reg[15] [11]),
        .I1(s_axi_gcd_bus_ARADDR[3]),
        .I2(\a_read_reg_107_reg[15] [11]),
        .I3(s_axi_gcd_bus_ARADDR[4]),
        .I4(s_axi_gcd_bus_ARADDR[5]),
        .I5(int_pResult[11]),
        .O(\rdata[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0033B8000000B800)) 
    \rdata[12]_i_1 
       (.I0(\b_read_reg_102_reg[15] [12]),
        .I1(s_axi_gcd_bus_ARADDR[3]),
        .I2(\a_read_reg_107_reg[15] [12]),
        .I3(s_axi_gcd_bus_ARADDR[4]),
        .I4(s_axi_gcd_bus_ARADDR[5]),
        .I5(int_pResult[12]),
        .O(\rdata[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0033B8000000B800)) 
    \rdata[13]_i_1 
       (.I0(\b_read_reg_102_reg[15] [13]),
        .I1(s_axi_gcd_bus_ARADDR[3]),
        .I2(\a_read_reg_107_reg[15] [13]),
        .I3(s_axi_gcd_bus_ARADDR[4]),
        .I4(s_axi_gcd_bus_ARADDR[5]),
        .I5(int_pResult[13]),
        .O(\rdata[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0033B8000000B800)) 
    \rdata[14]_i_1 
       (.I0(\b_read_reg_102_reg[15] [14]),
        .I1(s_axi_gcd_bus_ARADDR[3]),
        .I2(\a_read_reg_107_reg[15] [14]),
        .I3(s_axi_gcd_bus_ARADDR[4]),
        .I4(s_axi_gcd_bus_ARADDR[5]),
        .I5(int_pResult[14]),
        .O(\rdata[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h88888880)) 
    \rdata[15]_i_1 
       (.I0(s_axi_gcd_bus_ARVALID),
        .I1(s_axi_gcd_bus_RVALID[0]),
        .I2(s_axi_gcd_bus_ARADDR[1]),
        .I3(s_axi_gcd_bus_ARADDR[0]),
        .I4(s_axi_gcd_bus_ARADDR[2]),
        .O(\rdata[15]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \rdata[15]_i_2 
       (.I0(s_axi_gcd_bus_RVALID[0]),
        .I1(s_axi_gcd_bus_ARVALID),
        .O(ar_hs));
  LUT6 #(
    .INIT(64'h0033B8000000B800)) 
    \rdata[15]_i_3 
       (.I0(\b_read_reg_102_reg[15] [15]),
        .I1(s_axi_gcd_bus_ARADDR[3]),
        .I2(\a_read_reg_107_reg[15] [15]),
        .I3(s_axi_gcd_bus_ARADDR[4]),
        .I4(s_axi_gcd_bus_ARADDR[5]),
        .I5(int_pResult[15]),
        .O(\rdata[15]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rdata[1]_i_1 
       (.I0(\rdata[1]_i_2_n_0 ),
        .I1(s_axi_gcd_bus_ARADDR[2]),
        .I2(\rdata[1]_i_3_n_0 ),
        .I3(\rdata[1]_i_4_n_0 ),
        .I4(ar_hs),
        .I5(s_axi_gcd_bus_RDATA[1]),
        .O(\rdata[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rdata[1]_i_2 
       (.I0(\int_ier_reg_n_0_[1] ),
        .I1(s_axi_gcd_bus_ARADDR[4]),
        .I2(\b_read_reg_102_reg[15] [1]),
        .I3(s_axi_gcd_bus_ARADDR[5]),
        .I4(s_axi_gcd_bus_ARADDR[3]),
        .I5(\rdata[1]_i_5_n_0 ),
        .O(\rdata[1]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h1000)) 
    \rdata[1]_i_3 
       (.I0(s_axi_gcd_bus_ARADDR[4]),
        .I1(s_axi_gcd_bus_ARADDR[5]),
        .I2(s_axi_gcd_bus_ARADDR[3]),
        .I3(p_1_in),
        .O(\rdata[1]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \rdata[1]_i_4 
       (.I0(s_axi_gcd_bus_ARADDR[1]),
        .I1(s_axi_gcd_bus_ARADDR[0]),
        .O(\rdata[1]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \rdata[1]_i_5 
       (.I0(\a_read_reg_107_reg[15] [1]),
        .I1(s_axi_gcd_bus_ARADDR[4]),
        .I2(int_pResult[1]),
        .I3(s_axi_gcd_bus_ARADDR[5]),
        .I4(int_ap_done),
        .O(\rdata[1]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h40FF4000)) 
    \rdata[2]_i_1 
       (.I0(s_axi_gcd_bus_ARADDR[5]),
        .I1(s_axi_gcd_bus_ARADDR[4]),
        .I2(\b_read_reg_102_reg[15] [2]),
        .I3(s_axi_gcd_bus_ARADDR[3]),
        .I4(\rdata[2]_i_2_n_0 ),
        .O(\rdata[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \rdata[2]_i_2 
       (.I0(\a_read_reg_107_reg[15] [2]),
        .I1(s_axi_gcd_bus_ARADDR[4]),
        .I2(int_pResult[2]),
        .I3(s_axi_gcd_bus_ARADDR[5]),
        .I4(int_ap_idle),
        .O(\rdata[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h40FF4000)) 
    \rdata[3]_i_1 
       (.I0(s_axi_gcd_bus_ARADDR[5]),
        .I1(s_axi_gcd_bus_ARADDR[4]),
        .I2(\b_read_reg_102_reg[15] [3]),
        .I3(s_axi_gcd_bus_ARADDR[3]),
        .I4(\rdata[3]_i_2_n_0 ),
        .O(\rdata[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \rdata[3]_i_2 
       (.I0(\a_read_reg_107_reg[15] [3]),
        .I1(s_axi_gcd_bus_ARADDR[4]),
        .I2(int_pResult[3]),
        .I3(s_axi_gcd_bus_ARADDR[5]),
        .I4(int_ap_ready),
        .O(\rdata[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0033B8000000B800)) 
    \rdata[4]_i_1 
       (.I0(\b_read_reg_102_reg[15] [4]),
        .I1(s_axi_gcd_bus_ARADDR[3]),
        .I2(\a_read_reg_107_reg[15] [4]),
        .I3(s_axi_gcd_bus_ARADDR[4]),
        .I4(s_axi_gcd_bus_ARADDR[5]),
        .I5(int_pResult[4]),
        .O(\rdata[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0033B8000000B800)) 
    \rdata[5]_i_1 
       (.I0(\b_read_reg_102_reg[15] [5]),
        .I1(s_axi_gcd_bus_ARADDR[3]),
        .I2(\a_read_reg_107_reg[15] [5]),
        .I3(s_axi_gcd_bus_ARADDR[4]),
        .I4(s_axi_gcd_bus_ARADDR[5]),
        .I5(int_pResult[5]),
        .O(\rdata[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0033B8000000B800)) 
    \rdata[6]_i_1 
       (.I0(\b_read_reg_102_reg[15] [6]),
        .I1(s_axi_gcd_bus_ARADDR[3]),
        .I2(\a_read_reg_107_reg[15] [6]),
        .I3(s_axi_gcd_bus_ARADDR[4]),
        .I4(s_axi_gcd_bus_ARADDR[5]),
        .I5(int_pResult[6]),
        .O(\rdata[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h40FF4000)) 
    \rdata[7]_i_1 
       (.I0(s_axi_gcd_bus_ARADDR[5]),
        .I1(s_axi_gcd_bus_ARADDR[4]),
        .I2(\b_read_reg_102_reg[15] [7]),
        .I3(s_axi_gcd_bus_ARADDR[3]),
        .I4(\rdata[7]_i_2_n_0 ),
        .O(\rdata[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \rdata[7]_i_2 
       (.I0(\a_read_reg_107_reg[15] [7]),
        .I1(s_axi_gcd_bus_ARADDR[4]),
        .I2(int_pResult[7]),
        .I3(s_axi_gcd_bus_ARADDR[5]),
        .I4(int_auto_restart),
        .O(\rdata[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0033B8000000B800)) 
    \rdata[8]_i_1 
       (.I0(\b_read_reg_102_reg[15] [8]),
        .I1(s_axi_gcd_bus_ARADDR[3]),
        .I2(\a_read_reg_107_reg[15] [8]),
        .I3(s_axi_gcd_bus_ARADDR[4]),
        .I4(s_axi_gcd_bus_ARADDR[5]),
        .I5(int_pResult[8]),
        .O(\rdata[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0033B8000000B800)) 
    \rdata[9]_i_1 
       (.I0(\b_read_reg_102_reg[15] [9]),
        .I1(s_axi_gcd_bus_ARADDR[3]),
        .I2(\a_read_reg_107_reg[15] [9]),
        .I3(s_axi_gcd_bus_ARADDR[4]),
        .I4(s_axi_gcd_bus_ARADDR[5]),
        .I5(int_pResult[9]),
        .O(\rdata[9]_i_1_n_0 ));
  FDRE \rdata_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\rdata[0]_i_1_n_0 ),
        .Q(s_axi_gcd_bus_RDATA[0]),
        .R(1'b0));
  FDRE \rdata_reg[10] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[10]_i_1_n_0 ),
        .Q(s_axi_gcd_bus_RDATA[10]),
        .R(\rdata[15]_i_1_n_0 ));
  FDRE \rdata_reg[11] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[11]_i_1_n_0 ),
        .Q(s_axi_gcd_bus_RDATA[11]),
        .R(\rdata[15]_i_1_n_0 ));
  FDRE \rdata_reg[12] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[12]_i_1_n_0 ),
        .Q(s_axi_gcd_bus_RDATA[12]),
        .R(\rdata[15]_i_1_n_0 ));
  FDRE \rdata_reg[13] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[13]_i_1_n_0 ),
        .Q(s_axi_gcd_bus_RDATA[13]),
        .R(\rdata[15]_i_1_n_0 ));
  FDRE \rdata_reg[14] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[14]_i_1_n_0 ),
        .Q(s_axi_gcd_bus_RDATA[14]),
        .R(\rdata[15]_i_1_n_0 ));
  FDRE \rdata_reg[15] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[15]_i_3_n_0 ),
        .Q(s_axi_gcd_bus_RDATA[15]),
        .R(\rdata[15]_i_1_n_0 ));
  FDRE \rdata_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\rdata[1]_i_1_n_0 ),
        .Q(s_axi_gcd_bus_RDATA[1]),
        .R(1'b0));
  FDRE \rdata_reg[2] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[2]_i_1_n_0 ),
        .Q(s_axi_gcd_bus_RDATA[2]),
        .R(\rdata[15]_i_1_n_0 ));
  FDRE \rdata_reg[3] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[3]_i_1_n_0 ),
        .Q(s_axi_gcd_bus_RDATA[3]),
        .R(\rdata[15]_i_1_n_0 ));
  FDRE \rdata_reg[4] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[4]_i_1_n_0 ),
        .Q(s_axi_gcd_bus_RDATA[4]),
        .R(\rdata[15]_i_1_n_0 ));
  FDRE \rdata_reg[5] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[5]_i_1_n_0 ),
        .Q(s_axi_gcd_bus_RDATA[5]),
        .R(\rdata[15]_i_1_n_0 ));
  FDRE \rdata_reg[6] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[6]_i_1_n_0 ),
        .Q(s_axi_gcd_bus_RDATA[6]),
        .R(\rdata[15]_i_1_n_0 ));
  FDRE \rdata_reg[7] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[7]_i_1_n_0 ),
        .Q(s_axi_gcd_bus_RDATA[7]),
        .R(\rdata[15]_i_1_n_0 ));
  FDRE \rdata_reg[8] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[8]_i_1_n_0 ),
        .Q(s_axi_gcd_bus_RDATA[8]),
        .R(\rdata[15]_i_1_n_0 ));
  FDRE \rdata_reg[9] 
       (.C(ap_clk),
        .CE(ar_hs),
        .D(\rdata[9]_i_1_n_0 ),
        .Q(s_axi_gcd_bus_RDATA[9]),
        .R(\rdata[15]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \waddr[5]_i_1 
       (.I0(out[0]),
        .I1(s_axi_gcd_bus_AWVALID),
        .O(waddr));
  FDRE \waddr_reg[0] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_gcd_bus_AWADDR[0]),
        .Q(\waddr_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \waddr_reg[1] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_gcd_bus_AWADDR[1]),
        .Q(\waddr_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \waddr_reg[2] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_gcd_bus_AWADDR[2]),
        .Q(\waddr_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \waddr_reg[3] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_gcd_bus_AWADDR[3]),
        .Q(\waddr_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \waddr_reg[4] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_gcd_bus_AWADDR[4]),
        .Q(\waddr_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \waddr_reg[5] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_gcd_bus_AWADDR[5]),
        .Q(\waddr_reg_n_0_[5] ),
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
