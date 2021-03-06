// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2018.2
// Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="gcd,hls_ip_2018_2,{HLS_INPUT_TYPE=c,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7z010clg400-1,HLS_INPUT_CLOCK=3.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=2.429000,HLS_SYN_LAT=-1,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=203,HLS_SYN_LUT=285,HLS_VERSION=2018_2}" *)

module gcd (
        ap_clk,
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
        interrupt
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;
parameter    C_S_AXI_GCD_BUS_DATA_WIDTH = 32;
parameter    C_S_AXI_GCD_BUS_ADDR_WIDTH = 6;
parameter    C_S_AXI_DATA_WIDTH = 32;

parameter C_S_AXI_GCD_BUS_WSTRB_WIDTH = (32 / 8);
parameter C_S_AXI_WSTRB_WIDTH = (32 / 8);

input   ap_clk;
input   ap_rst_n;
input   s_axi_gcd_bus_AWVALID;
output   s_axi_gcd_bus_AWREADY;
input  [C_S_AXI_GCD_BUS_ADDR_WIDTH - 1:0] s_axi_gcd_bus_AWADDR;
input   s_axi_gcd_bus_WVALID;
output   s_axi_gcd_bus_WREADY;
input  [C_S_AXI_GCD_BUS_DATA_WIDTH - 1:0] s_axi_gcd_bus_WDATA;
input  [C_S_AXI_GCD_BUS_WSTRB_WIDTH - 1:0] s_axi_gcd_bus_WSTRB;
input   s_axi_gcd_bus_ARVALID;
output   s_axi_gcd_bus_ARREADY;
input  [C_S_AXI_GCD_BUS_ADDR_WIDTH - 1:0] s_axi_gcd_bus_ARADDR;
output   s_axi_gcd_bus_RVALID;
input   s_axi_gcd_bus_RREADY;
output  [C_S_AXI_GCD_BUS_DATA_WIDTH - 1:0] s_axi_gcd_bus_RDATA;
output  [1:0] s_axi_gcd_bus_RRESP;
output   s_axi_gcd_bus_BVALID;
input   s_axi_gcd_bus_BREADY;
output  [1:0] s_axi_gcd_bus_BRESP;
output   interrupt;

 reg    ap_rst_n_inv;
wire    ap_start;
reg    ap_done;
reg    ap_idle;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    ap_ready;
wire   [15:0] a;
wire   [15:0] b;
reg    pResult_ap_vld;
reg   [15:0] b_read_reg_102;
reg   [15:0] a_read_reg_107;
wire   [0:0] tmp_3_fu_72_p2;
reg   [0:0] tmp_3_reg_115;
wire    ap_CS_fsm_state3;
wire   [0:0] tmp_2_fu_66_p2;
wire   [15:0] a_assign_fu_78_p2;
reg   [15:0] a_assign_reg_121;
wire   [15:0] b_assign_fu_84_p2;
reg   [15:0] b_assign_reg_126;
wire   [15:0] b_assign_1_fu_90_p3;
wire    ap_CS_fsm_state4;
wire   [15:0] a_assign_1_fu_96_p3;
reg   [15:0] p_s_reg_45;
wire    ap_CS_fsm_state2;
reg   [15:0] result_reg_56;
reg   [3:0] ap_NS_fsm;

// power-on initialization
initial begin
#0 ap_CS_fsm = 4'd1;
end

gcd_gcd_bus_s_axi #(
    .C_S_AXI_ADDR_WIDTH( C_S_AXI_GCD_BUS_ADDR_WIDTH ),
    .C_S_AXI_DATA_WIDTH( C_S_AXI_GCD_BUS_DATA_WIDTH ))
gcd_gcd_bus_s_axi_U(
    .AWVALID(s_axi_gcd_bus_AWVALID),
    .AWREADY(s_axi_gcd_bus_AWREADY),
    .AWADDR(s_axi_gcd_bus_AWADDR),
    .WVALID(s_axi_gcd_bus_WVALID),
    .WREADY(s_axi_gcd_bus_WREADY),
    .WDATA(s_axi_gcd_bus_WDATA),
    .WSTRB(s_axi_gcd_bus_WSTRB),
    .ARVALID(s_axi_gcd_bus_ARVALID),
    .ARREADY(s_axi_gcd_bus_ARREADY),
    .ARADDR(s_axi_gcd_bus_ARADDR),
    .RVALID(s_axi_gcd_bus_RVALID),
    .RREADY(s_axi_gcd_bus_RREADY),
    .RDATA(s_axi_gcd_bus_RDATA),
    .RRESP(s_axi_gcd_bus_RRESP),
    .BVALID(s_axi_gcd_bus_BVALID),
    .BREADY(s_axi_gcd_bus_BREADY),
    .BRESP(s_axi_gcd_bus_BRESP),
    .ACLK(ap_clk),
    .ARESET(ap_rst_n_inv),
    .ACLK_EN(1'b1),
    .ap_start(ap_start),
    .interrupt(interrupt),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_idle(ap_idle),
    .a(a),
    .b(b),
    .pResult(p_s_reg_45),
    .pResult_ap_vld(pResult_ap_vld)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        p_s_reg_45 <= b_assign_1_fu_90_p3;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        p_s_reg_45 <= b_read_reg_102;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        result_reg_56 <= a_assign_1_fu_96_p3;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        result_reg_56 <= a_read_reg_107;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_2_fu_66_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state3))) begin
        a_assign_reg_121 <= a_assign_fu_78_p2;
        b_assign_reg_126 <= b_assign_fu_84_p2;
        tmp_3_reg_115 <= tmp_3_fu_72_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
        a_read_reg_107 <= a;
        b_read_reg_102 <= b;
    end
end

always @ (*) begin
    if (((tmp_2_fu_66_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state3))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((tmp_2_fu_66_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state3))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((tmp_2_fu_66_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state3))) begin
        pResult_ap_vld = 1'b1;
    end else begin
        pResult_ap_vld = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((tmp_2_fu_66_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign a_assign_1_fu_96_p3 = ((tmp_3_reg_115[0:0] === 1'b1) ? a_assign_reg_121 : result_reg_56);

assign a_assign_fu_78_p2 = (result_reg_56 - p_s_reg_45);

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign b_assign_1_fu_90_p3 = ((tmp_3_reg_115[0:0] === 1'b1) ? p_s_reg_45 : b_assign_reg_126);

assign b_assign_fu_84_p2 = (p_s_reg_45 - result_reg_56);

assign tmp_2_fu_66_p2 = ((result_reg_56 == p_s_reg_45) ? 1'b1 : 1'b0);

assign tmp_3_fu_72_p2 = (($signed(result_reg_56) > $signed(p_s_reg_45)) ? 1'b1 : 1'b0);

endmodule //gcd
