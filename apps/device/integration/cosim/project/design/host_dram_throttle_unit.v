// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2017.1
// Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="host_dram_throttle_unit,hls_ip_2017_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xcvu9p-flgb2104-2-i,HLS_INPUT_CLOCK=4.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=3.196250,HLS_SYN_LAT=-1,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=1312,HLS_SYN_LUT=1011}" *)

module host_dram_throttle_unit (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
ap_continue,
        ap_idle,
        ap_ready,
        host_dram_write_req_data_throttled_V_last_din,
        host_dram_write_req_data_throttled_V_last_full_n,
        host_dram_write_req_data_throttled_V_last_write,
        host_dram_write_req_data_throttled_V_data_V_din,
        host_dram_write_req_data_throttled_V_data_V_full_n,
        host_dram_write_req_data_throttled_V_data_V_write,
        host_dram_write_req_data_delayed_V_last_dout,
        host_dram_write_req_data_delayed_V_last_empty_n,
        host_dram_write_req_data_delayed_V_last_read,
        host_dram_write_req_data_delayed_V_data_V_dout,
        host_dram_write_req_data_delayed_V_data_V_empty_n,
        host_dram_write_req_data_delayed_V_data_V_read,
        host_dram_read_resp_throttled_V_last_dout,
        host_dram_read_resp_throttled_V_last_empty_n,
        host_dram_read_resp_throttled_V_last_read,
        host_dram_read_resp_throttled_V_data_V_dout,
        host_dram_read_resp_throttled_V_data_V_empty_n,
        host_dram_read_resp_throttled_V_data_V_read,
        host_dram_read_resp_delayed_V_last_din,
        host_dram_read_resp_delayed_V_last_full_n,
        host_dram_read_resp_delayed_V_last_write,
        host_dram_read_resp_delayed_V_data_V_din,
        host_dram_read_resp_delayed_V_data_V_full_n,
        host_dram_read_resp_delayed_V_data_V_write,
        host_throttle_params_V_dout,
        host_throttle_params_V_empty_n,
        host_throttle_params_V_read
);

parameter    ap_ST_fsm_state1 = 2'd1;
parameter    ap_ST_fsm_pp0_stage0 = 2'd2;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output ap_ready; output ap_continue;
output   host_dram_write_req_data_throttled_V_last_din;
input   host_dram_write_req_data_throttled_V_last_full_n;
output   host_dram_write_req_data_throttled_V_last_write;
output  [511:0] host_dram_write_req_data_throttled_V_data_V_din;
input   host_dram_write_req_data_throttled_V_data_V_full_n;
output   host_dram_write_req_data_throttled_V_data_V_write;
input   host_dram_write_req_data_delayed_V_last_dout;
input   host_dram_write_req_data_delayed_V_last_empty_n;
output   host_dram_write_req_data_delayed_V_last_read;
input  [511:0] host_dram_write_req_data_delayed_V_data_V_dout;
input   host_dram_write_req_data_delayed_V_data_V_empty_n;
output   host_dram_write_req_data_delayed_V_data_V_read;
input   host_dram_read_resp_throttled_V_last_dout;
input   host_dram_read_resp_throttled_V_last_empty_n;
output   host_dram_read_resp_throttled_V_last_read;
input  [511:0] host_dram_read_resp_throttled_V_data_V_dout;
input   host_dram_read_resp_throttled_V_data_V_empty_n;
output   host_dram_read_resp_throttled_V_data_V_read;
output   host_dram_read_resp_delayed_V_last_din;
input   host_dram_read_resp_delayed_V_last_full_n;
output   host_dram_read_resp_delayed_V_last_write;
output  [511:0] host_dram_read_resp_delayed_V_data_V_din;
input   host_dram_read_resp_delayed_V_data_V_full_n;
output   host_dram_read_resp_delayed_V_data_V_write;
input  [31:0] host_throttle_params_V_dout;
input   host_throttle_params_V_empty_n;
output   host_throttle_params_V_read;

reg ap_idle;
reg host_throttle_params_V_read;

(* fsm_encoding = "none" *) reg   [1:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg   [31:0] throttle_threshold_reg_256;
reg   [31:0] throttle_cnt_reg_267;
reg   [0:0] valid_write_req_data_reg_278;
reg   [0:0] valid_read_resp_reg_290;
reg   [0:0] empty_n_reg_871;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_block_state2_pp0_stage0_iter0;
wire    ap_block_state3_pp0_stage0_iter1;
wire    ap_block_state4_pp0_stage0_iter2;
wire    ap_block_pp0_stage0_11001;
wire   [15:0] throttle_cnt_2_fu_440_p1;
reg   [15:0] throttle_cnt_2_reg_882;
reg   [15:0] throttle_threshold_1_reg_887;
wire   [31:0] throttle_threshold_3_fu_494_p3;
reg   [31:0] throttle_threshold_3_reg_892;
reg    ap_enable_reg_pp0_iter1;
wire   [31:0] throttle_cnt_1_fu_501_p3;
reg   [31:0] throttle_cnt_1_reg_897;
wire   [0:0] write_req_stall_1_fu_513_p2;
wire   [0:0] read_resp_stall_1_fu_527_p2;
wire   [0:0] empty_n_3_fu_541_p1;
reg   [0:0] valid_write_req_data_phi_fu_282_p4;
wire   [0:0] or_cond_fu_573_p2;
wire   [0:0] empty_n_4_fu_653_p1;
reg   [0:0] valid_read_resp_phi_fu_294_p4;
wire   [0:0] or_cond1_fu_685_p2;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0_subdone;
reg    ap_enable_reg_pp0_iter2;
reg   [31:0] throttle_threshold_phi_fu_260_p4;
wire    ap_block_pp0_stage0;
reg   [31:0] throttle_cnt_phi_fu_271_p4;
reg   [0:0] valid_write_req_data_5_phi_fu_328_p4;
reg   [0:0] valid_read_resp_5_phi_fu_362_p4;
wire   [0:0] ap_phi_precharge_reg_pp0_iter1_valid_write_req_data_3_reg_302;
reg   [0:0] ap_phi_precharge_reg_pp0_iter2_valid_write_req_data_3_reg_302;
wire   [0:0] valid_write_req_data_3_phi_fu_307_p10;
wire   [0:0] not_full_n_i5_fu_773_p2;
wire   [0:0] ap_phi_precharge_reg_pp0_iter2_valid_write_req_data_5_reg_324;
wire   [0:0] ap_phi_precharge_reg_pp0_iter1_valid_read_resp_3_reg_336;
reg   [0:0] ap_phi_precharge_reg_pp0_iter2_valid_read_resp_3_reg_336;
wire   [0:0] valid_read_resp_3_phi_fu_341_p10;
wire   [0:0] not_full_n_i_fu_788_p2;
wire   [0:0] ap_phi_precharge_reg_pp0_iter2_valid_read_resp_5_reg_358;
reg    host_dram_write_req_data_delayed_V_last0_update;
wire   [0:0] empty_n_1_nbread_fu_220_p3_0;
reg    host_dram_read_resp_throttled_V_last0_update;
wire   [0:0] empty_n_2_nbread_fu_228_p3_0;
reg    host_dram_write_req_data_throttled_V_last1_update;
wire   [0:0] full_n_nbwrite_fu_236_p5;
wire    ap_block_pp0_stage0_01001;
reg    host_dram_read_resp_delayed_V_last1_update;
wire   [0:0] full_n_1_nbwrite_fu_246_p5;
reg   [31:0] read_resp_stall_times_fu_174;
wire   [31:0] read_resp_stall_times_1_fu_533_p3;
wire   [31:0] p_2_fu_742_p3;
reg   [0:0] read_resp_stall_fu_178;
wire   [0:0] tmp_6_fu_695_p2;
wire   [0:0] not_s_fu_736_p2;
reg   [31:0] write_req_stall_times_fu_182;
wire   [31:0] write_req_stall_times_1_fu_519_p3;
wire   [31:0] p_s_fu_630_p3;
reg   [0:0] write_req_stall_fu_186;
wire   [0:0] tmp_s_fu_583_p2;
wire   [0:0] not_1_fu_624_p2;
reg   [24:0] read_resp_contiguous_times_V_1_fu_190;
wire   [24:0] p_3_fu_701_p3;
wire   [24:0] read_resp_contiguous_times_V_fu_667_p2;
wire   [24:0] p_062_1_fu_486_p3;
reg   [24:0] write_req_contiguous_times_V_1_fu_194;
wire   [24:0] p_1_fu_589_p3;
wire   [24:0] write_req_contiguous_times_V_fu_555_p2;
wire   [24:0] p_0_1_fu_478_p3;
reg   [0:0] tmp_last_fu_198;
reg   [511:0] tmp_data_V_fu_202;
reg   [0:0] tmp_last_1_fu_206;
reg   [511:0] tmp_data_V_1_fu_210;
wire   [31:0] throttle_threshold_2_fu_472_p1;
wire   [31:0] throttle_cnt_2_cast_fu_475_p1;
wire   [0:0] not_empty_n_fu_508_p2;
wire   [0:0] tmp_7_fu_561_p2;
wire   [0:0] tmp_8_fu_567_p2;
wire   [31:0] tmp_9_fu_579_p1;
wire   [31:0] write_req_stall_times_2_fu_612_p2;
wire   [0:0] tmp_4_fu_618_p2;
wire   [0:0] tmp_2_fu_673_p2;
wire   [0:0] tmp_3_fu_679_p2;
wire   [31:0] tmp_5_fu_691_p1;
wire   [31:0] read_resp_stall_times_2_fu_724_p2;
wire   [0:0] tmp_1_fu_730_p2;
reg   [1:0] ap_NS_fsm;
reg    ap_idle_pp0;
wire    ap_enable_pp0;

// power-on initialization
initial begin
#0 ap_CS_fsm = 2'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((ap_block_pp0_stage0_subdone == 1'b0)) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((ap_block_pp0_stage0_subdone == 1'b0)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end else if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
            ap_enable_reg_pp0_iter2 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd0) & (1'd1 == empty_n_4_fu_653_p1) & (1'd1 == or_cond1_fu_685_p2)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd0) & (1'd1 == empty_n_4_fu_653_p1) & (1'd0 == or_cond1_fu_685_p2)))) begin
        ap_phi_precharge_reg_pp0_iter2_valid_read_resp_3_reg_336 <= 1'd1;
    end else if ((((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd1)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd0) & (1'd0 == empty_n_4_fu_653_p1)))) begin
        ap_phi_precharge_reg_pp0_iter2_valid_read_resp_3_reg_336 <= 1'd0;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd1 == valid_read_resp_phi_fu_294_p4))) begin
        ap_phi_precharge_reg_pp0_iter2_valid_read_resp_3_reg_336 <= valid_read_resp_phi_fu_294_p4;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1))) begin
        ap_phi_precharge_reg_pp0_iter2_valid_read_resp_3_reg_336 <= ap_phi_precharge_reg_pp0_iter1_valid_read_resp_3_reg_336;
    end
end

always @ (posedge ap_clk) begin
    if ((((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd0) & (empty_n_3_fu_541_p1 == 1'd1) & (or_cond_fu_573_p2 == 1'd1)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd0) & (empty_n_3_fu_541_p1 == 1'd1) & (1'd0 == or_cond_fu_573_p2)))) begin
        ap_phi_precharge_reg_pp0_iter2_valid_write_req_data_3_reg_302 <= 1'd1;
    end else if ((((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd1)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd0) & (empty_n_3_fu_541_p1 == 1'd0)))) begin
        ap_phi_precharge_reg_pp0_iter2_valid_write_req_data_3_reg_302 <= 1'd0;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd1))) begin
        ap_phi_precharge_reg_pp0_iter2_valid_write_req_data_3_reg_302 <= valid_write_req_data_phi_fu_282_p4;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1))) begin
        ap_phi_precharge_reg_pp0_iter2_valid_write_req_data_3_reg_302 <= ap_phi_precharge_reg_pp0_iter1_valid_write_req_data_3_reg_302;
    end
end

always @ (posedge ap_clk) begin
    if ((((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd1 == valid_read_resp_phi_fu_294_p4)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd1)))) begin
        read_resp_contiguous_times_V_1_fu_190 <= p_062_1_fu_486_p3;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd0) & (1'd1 == empty_n_4_fu_653_p1) & (1'd1 == or_cond1_fu_685_p2))) begin
        read_resp_contiguous_times_V_1_fu_190 <= read_resp_contiguous_times_V_fu_667_p2;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd0) & (1'd1 == empty_n_4_fu_653_p1) & (1'd0 == or_cond1_fu_685_p2))) begin
        read_resp_contiguous_times_V_1_fu_190 <= p_3_fu_701_p3;
    end else if ((((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd0) & (1'd0 == empty_n_4_fu_653_p1)))) begin
        read_resp_contiguous_times_V_1_fu_190 <= 25'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd1 == valid_read_resp_phi_fu_294_p4))) begin
        read_resp_stall_fu_178 <= read_resp_stall_1_fu_527_p2;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd1))) begin
        read_resp_stall_fu_178 <= not_s_fu_736_p2;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd0) & (1'd1 == empty_n_4_fu_653_p1) & (1'd0 == or_cond1_fu_685_p2))) begin
        read_resp_stall_fu_178 <= tmp_6_fu_695_p2;
    end else if ((((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd0) & (1'd1 == empty_n_4_fu_653_p1) & (1'd1 == or_cond1_fu_685_p2)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd0) & (1'd0 == empty_n_4_fu_653_p1)))) begin
        read_resp_stall_fu_178 <= 1'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd1))) begin
        read_resp_stall_times_fu_174 <= p_2_fu_742_p3;
    end else if ((((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd1 == valid_read_resp_phi_fu_294_p4)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd0) & (1'd1 == empty_n_4_fu_653_p1) & (1'd1 == or_cond1_fu_685_p2)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd0) & (1'd1 == empty_n_4_fu_653_p1) & (1'd0 == or_cond1_fu_685_p2)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd0) & (1'd0 == empty_n_4_fu_653_p1)))) begin
        read_resp_stall_times_fu_174 <= read_resp_stall_times_1_fu_533_p3;
    end else if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
        read_resp_stall_times_fu_174 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter2))) begin
        throttle_cnt_reg_267 <= throttle_cnt_1_reg_897;
    end else if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
        throttle_cnt_reg_267 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter2))) begin
        throttle_threshold_reg_256 <= throttle_threshold_3_reg_892;
    end else if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
        throttle_threshold_reg_256 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter2))) begin
        valid_read_resp_reg_290 <= valid_read_resp_5_phi_fu_362_p4;
    end else if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
        valid_read_resp_reg_290 <= 1'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter2))) begin
        valid_write_req_data_reg_278 <= valid_write_req_data_5_phi_fu_328_p4;
    end else if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
        valid_write_req_data_reg_278 <= 1'd0;
    end
end

always @ (posedge ap_clk) begin
    if ((((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd1)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd1)))) begin
        write_req_contiguous_times_V_1_fu_194 <= p_0_1_fu_478_p3;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd0) & (empty_n_3_fu_541_p1 == 1'd1) & (or_cond_fu_573_p2 == 1'd1))) begin
        write_req_contiguous_times_V_1_fu_194 <= write_req_contiguous_times_V_fu_555_p2;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd0) & (empty_n_3_fu_541_p1 == 1'd1) & (1'd0 == or_cond_fu_573_p2))) begin
        write_req_contiguous_times_V_1_fu_194 <= p_1_fu_589_p3;
    end else if ((((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd0) & (empty_n_3_fu_541_p1 == 1'd0)))) begin
        write_req_contiguous_times_V_1_fu_194 <= 25'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd1))) begin
        write_req_stall_fu_186 <= write_req_stall_1_fu_513_p2;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd1))) begin
        write_req_stall_fu_186 <= not_1_fu_624_p2;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd0) & (empty_n_3_fu_541_p1 == 1'd1) & (1'd0 == or_cond_fu_573_p2))) begin
        write_req_stall_fu_186 <= tmp_s_fu_583_p2;
    end else if ((((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd0) & (empty_n_3_fu_541_p1 == 1'd1) & (or_cond_fu_573_p2 == 1'd1)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd0) & (empty_n_3_fu_541_p1 == 1'd0)))) begin
        write_req_stall_fu_186 <= 1'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd1))) begin
        write_req_stall_times_fu_182 <= p_s_fu_630_p3;
    end else if ((((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd1)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd0) & (empty_n_3_fu_541_p1 == 1'd1) & (or_cond_fu_573_p2 == 1'd1)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd0) & (empty_n_3_fu_541_p1 == 1'd1) & (1'd0 == or_cond_fu_573_p2)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd0) & (empty_n_3_fu_541_p1 == 1'd0)))) begin
        write_req_stall_times_fu_182 <= write_req_stall_times_1_fu_519_p3;
    end else if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
        write_req_stall_times_fu_182 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0))) begin
        empty_n_reg_871 <= host_throttle_params_V_empty_n;
        throttle_cnt_2_reg_882 <= throttle_cnt_2_fu_440_p1;
        throttle_threshold_1_reg_887 <= {{host_throttle_params_V_dout[31:16]}};
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1))) begin
        throttle_cnt_1_reg_897 <= throttle_cnt_1_fu_501_p3;
        throttle_threshold_3_reg_892 <= throttle_threshold_3_fu_494_p3;
    end
end

always @ (posedge ap_clk) begin
    if ((((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd0) & (1'd1 == empty_n_4_fu_653_p1) & (1'd1 == or_cond1_fu_685_p2)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd0) & (1'd1 == empty_n_4_fu_653_p1) & (1'd0 == or_cond1_fu_685_p2)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd0) & (1'd0 == empty_n_4_fu_653_p1)))) begin
        tmp_data_V_1_fu_210 <= host_dram_read_resp_throttled_V_data_V_dout;
        tmp_last_1_fu_206 <= host_dram_read_resp_throttled_V_last_dout;
    end
end

always @ (posedge ap_clk) begin
    if ((((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd0) & (empty_n_3_fu_541_p1 == 1'd1) & (or_cond_fu_573_p2 == 1'd1)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd0) & (empty_n_3_fu_541_p1 == 1'd1) & (1'd0 == or_cond_fu_573_p2)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd0) & (empty_n_3_fu_541_p1 == 1'd0)))) begin
        tmp_data_V_fu_202 <= host_dram_write_req_data_delayed_V_data_V_dout;
        tmp_last_fu_198 <= host_dram_write_req_data_delayed_V_last_dout;
    end
end

always @ (*) begin
    if (((1'b0 == ap_start) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_enable_reg_pp0_iter0) & (1'b0 == ap_enable_reg_pp0_iter1) & (1'b0 == ap_enable_reg_pp0_iter2))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter2) & (1'd1 == valid_read_resp_3_phi_fu_341_p10) & (1'b1 == (host_dram_read_resp_delayed_V_last_full_n & host_dram_read_resp_delayed_V_data_V_full_n)))) begin
        host_dram_read_resp_delayed_V_last1_update = 1'b1;
    end else begin
        host_dram_read_resp_delayed_V_last1_update = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (1'd0 == valid_read_resp_phi_fu_294_p4) & (read_resp_stall_1_fu_527_p2 == 1'd0) & (1'b1 == (host_dram_read_resp_throttled_V_last_empty_n & host_dram_read_resp_throttled_V_data_V_empty_n)))) begin
        host_dram_read_resp_throttled_V_last0_update = 1'b1;
    end else begin
        host_dram_read_resp_throttled_V_last0_update = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter1) & (valid_write_req_data_phi_fu_282_p4 == 1'd0) & (write_req_stall_1_fu_513_p2 == 1'd0) & (1'b1 == (host_dram_write_req_data_delayed_V_last_empty_n & host_dram_write_req_data_delayed_V_data_V_empty_n)))) begin
        host_dram_write_req_data_delayed_V_last0_update = 1'b1;
    end else begin
        host_dram_write_req_data_delayed_V_last0_update = 1'b0;
    end
end

always @ (*) begin
    if (((ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter2) & (1'd1 == valid_write_req_data_3_phi_fu_307_p10) & (1'b1 == (host_dram_write_req_data_throttled_V_last_full_n & host_dram_write_req_data_throttled_V_data_V_full_n)))) begin
        host_dram_write_req_data_throttled_V_last1_update = 1'b1;
    end else begin
        host_dram_write_req_data_throttled_V_last1_update = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_11001 == 1'b0) & (1'b1 == ap_enable_reg_pp0_iter0) & (1'b1 == host_throttle_params_V_empty_n))) begin
        host_throttle_params_V_read = 1'b1;
    end else begin
        host_throttle_params_V_read = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_enable_reg_pp0_iter2) & (ap_block_pp0_stage0 == 1'b0))) begin
        throttle_cnt_phi_fu_271_p4 = throttle_cnt_1_reg_897;
    end else begin
        throttle_cnt_phi_fu_271_p4 = throttle_cnt_reg_267;
    end
end

always @ (*) begin
    if (((1'b1 == ap_enable_reg_pp0_iter2) & (ap_block_pp0_stage0 == 1'b0))) begin
        throttle_threshold_phi_fu_260_p4 = throttle_threshold_3_reg_892;
    end else begin
        throttle_threshold_phi_fu_260_p4 = throttle_threshold_reg_256;
    end
end

always @ (*) begin
    if (((1'b1 == ap_enable_reg_pp0_iter2) & (ap_block_pp0_stage0 == 1'b0))) begin
        if ((1'd0 == valid_read_resp_3_phi_fu_341_p10)) begin
            valid_read_resp_5_phi_fu_362_p4 = ap_phi_precharge_reg_pp0_iter2_valid_read_resp_3_reg_336;
        end else if ((1'd1 == valid_read_resp_3_phi_fu_341_p10)) begin
            valid_read_resp_5_phi_fu_362_p4 = not_full_n_i_fu_788_p2;
        end else begin
            valid_read_resp_5_phi_fu_362_p4 = ap_phi_precharge_reg_pp0_iter2_valid_read_resp_5_reg_358;
        end
    end else begin
        valid_read_resp_5_phi_fu_362_p4 = ap_phi_precharge_reg_pp0_iter2_valid_read_resp_5_reg_358;
    end
end

always @ (*) begin
    if (((1'b1 == ap_enable_reg_pp0_iter2) & (ap_block_pp0_stage0 == 1'b0))) begin
        valid_read_resp_phi_fu_294_p4 = valid_read_resp_5_phi_fu_362_p4;
    end else begin
        valid_read_resp_phi_fu_294_p4 = valid_read_resp_reg_290;
    end
end

always @ (*) begin
    if (((1'b1 == ap_enable_reg_pp0_iter2) & (ap_block_pp0_stage0 == 1'b0))) begin
        if ((1'd0 == valid_write_req_data_3_phi_fu_307_p10)) begin
            valid_write_req_data_5_phi_fu_328_p4 = ap_phi_precharge_reg_pp0_iter2_valid_write_req_data_3_reg_302;
        end else if ((1'd1 == valid_write_req_data_3_phi_fu_307_p10)) begin
            valid_write_req_data_5_phi_fu_328_p4 = not_full_n_i5_fu_773_p2;
        end else begin
            valid_write_req_data_5_phi_fu_328_p4 = ap_phi_precharge_reg_pp0_iter2_valid_write_req_data_5_reg_324;
        end
    end else begin
        valid_write_req_data_5_phi_fu_328_p4 = ap_phi_precharge_reg_pp0_iter2_valid_write_req_data_5_reg_324;
    end
end

always @ (*) begin
    if (((1'b1 == ap_enable_reg_pp0_iter2) & (ap_block_pp0_stage0 == 1'b0))) begin
        valid_write_req_data_phi_fu_282_p4 = valid_write_req_data_5_phi_fu_328_p4;
    end else begin
        valid_write_req_data_phi_fu_282_p4 = valid_write_req_data_reg_278;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_01001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_subdone = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state4_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_done = 1'b0;

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_phi_precharge_reg_pp0_iter1_valid_read_resp_3_reg_336 = 'bx;

assign ap_phi_precharge_reg_pp0_iter1_valid_write_req_data_3_reg_302 = 'bx;

assign ap_phi_precharge_reg_pp0_iter2_valid_read_resp_5_reg_358 = 'bx;

assign ap_phi_precharge_reg_pp0_iter2_valid_write_req_data_5_reg_324 = 'bx;

assign ap_ready = 1'b0;

assign empty_n_1_nbread_fu_220_p3_0 = (host_dram_write_req_data_delayed_V_last_empty_n & host_dram_write_req_data_delayed_V_data_V_empty_n);

assign empty_n_2_nbread_fu_228_p3_0 = (host_dram_read_resp_throttled_V_last_empty_n & host_dram_read_resp_throttled_V_data_V_empty_n);

assign empty_n_3_fu_541_p1 = empty_n_1_nbread_fu_220_p3_0;

assign empty_n_4_fu_653_p1 = empty_n_2_nbread_fu_228_p3_0;

assign full_n_1_nbwrite_fu_246_p5 = (host_dram_read_resp_delayed_V_last_full_n & host_dram_read_resp_delayed_V_data_V_full_n);

assign full_n_nbwrite_fu_236_p5 = (host_dram_write_req_data_throttled_V_last_full_n & host_dram_write_req_data_throttled_V_data_V_full_n);

assign host_dram_read_resp_delayed_V_data_V_din = tmp_data_V_1_fu_210;

assign host_dram_read_resp_delayed_V_data_V_write = host_dram_read_resp_delayed_V_last1_update;

assign host_dram_read_resp_delayed_V_last_din = tmp_last_1_fu_206;

assign host_dram_read_resp_delayed_V_last_write = host_dram_read_resp_delayed_V_last1_update;

assign host_dram_read_resp_throttled_V_data_V_read = host_dram_read_resp_throttled_V_last0_update;

assign host_dram_read_resp_throttled_V_last_read = host_dram_read_resp_throttled_V_last0_update;

assign host_dram_write_req_data_delayed_V_data_V_read = host_dram_write_req_data_delayed_V_last0_update;

assign host_dram_write_req_data_delayed_V_last_read = host_dram_write_req_data_delayed_V_last0_update;

assign host_dram_write_req_data_throttled_V_data_V_din = tmp_data_V_fu_202;

assign host_dram_write_req_data_throttled_V_data_V_write = host_dram_write_req_data_throttled_V_last1_update;

assign host_dram_write_req_data_throttled_V_last_din = tmp_last_fu_198;

assign host_dram_write_req_data_throttled_V_last_write = host_dram_write_req_data_throttled_V_last1_update;

assign not_1_fu_624_p2 = (tmp_4_fu_618_p2 ^ 1'd1);

assign not_empty_n_fu_508_p2 = (empty_n_reg_871 ^ 1'd1);

assign not_full_n_i5_fu_773_p2 = (full_n_nbwrite_fu_236_p5 ^ 1'd1);

assign not_full_n_i_fu_788_p2 = (full_n_1_nbwrite_fu_246_p5 ^ 1'd1);

assign not_s_fu_736_p2 = (tmp_1_fu_730_p2 ^ 1'd1);

assign or_cond1_fu_685_p2 = (tmp_2_fu_673_p2 | tmp_3_fu_679_p2);

assign or_cond_fu_573_p2 = (tmp_7_fu_561_p2 | tmp_8_fu_567_p2);

assign p_062_1_fu_486_p3 = ((empty_n_reg_871[0:0] === 1'b1) ? 25'd0 : read_resp_contiguous_times_V_1_fu_190);

assign p_0_1_fu_478_p3 = ((empty_n_reg_871[0:0] === 1'b1) ? 25'd0 : write_req_contiguous_times_V_1_fu_194);

assign p_1_fu_589_p3 = ((tmp_s_fu_583_p2[0:0] === 1'b1) ? 25'd0 : write_req_contiguous_times_V_fu_555_p2);

assign p_2_fu_742_p3 = ((tmp_1_fu_730_p2[0:0] === 1'b1) ? 32'd0 : read_resp_stall_times_2_fu_724_p2);

assign p_3_fu_701_p3 = ((tmp_6_fu_695_p2[0:0] === 1'b1) ? 25'd0 : read_resp_contiguous_times_V_fu_667_p2);

assign p_s_fu_630_p3 = ((tmp_4_fu_618_p2[0:0] === 1'b1) ? 32'd0 : write_req_stall_times_2_fu_612_p2);

assign read_resp_contiguous_times_V_fu_667_p2 = (p_062_1_fu_486_p3 + 25'd1);

assign read_resp_stall_1_fu_527_p2 = (read_resp_stall_fu_178 & not_empty_n_fu_508_p2);

assign read_resp_stall_times_1_fu_533_p3 = ((empty_n_reg_871[0:0] === 1'b1) ? 32'd0 : read_resp_stall_times_fu_174);

assign read_resp_stall_times_2_fu_724_p2 = (read_resp_stall_times_1_fu_533_p3 + 32'd1);

assign throttle_cnt_1_fu_501_p3 = ((empty_n_reg_871[0:0] === 1'b1) ? throttle_cnt_2_cast_fu_475_p1 : throttle_cnt_phi_fu_271_p4);

assign throttle_cnt_2_cast_fu_475_p1 = throttle_cnt_2_reg_882;

assign throttle_cnt_2_fu_440_p1 = host_throttle_params_V_dout[15:0];

assign throttle_threshold_2_fu_472_p1 = throttle_threshold_1_reg_887;

assign throttle_threshold_3_fu_494_p3 = ((empty_n_reg_871[0:0] === 1'b1) ? throttle_threshold_2_fu_472_p1 : throttle_threshold_phi_fu_260_p4);

assign tmp_1_fu_730_p2 = ((read_resp_stall_times_2_fu_724_p2 == throttle_cnt_1_fu_501_p3) ? 1'b1 : 1'b0);

assign tmp_2_fu_673_p2 = ((throttle_threshold_3_fu_494_p3 == 32'd0) ? 1'b1 : 1'b0);

assign tmp_3_fu_679_p2 = ((throttle_cnt_1_fu_501_p3 == 32'd0) ? 1'b1 : 1'b0);

assign tmp_4_fu_618_p2 = ((write_req_stall_times_2_fu_612_p2 == throttle_cnt_1_fu_501_p3) ? 1'b1 : 1'b0);

assign tmp_5_fu_691_p1 = read_resp_contiguous_times_V_fu_667_p2;

assign tmp_6_fu_695_p2 = ((tmp_5_fu_691_p1 == throttle_threshold_3_fu_494_p3) ? 1'b1 : 1'b0);

assign tmp_7_fu_561_p2 = ((throttle_threshold_3_fu_494_p3 == 32'd0) ? 1'b1 : 1'b0);

assign tmp_8_fu_567_p2 = ((throttle_cnt_1_fu_501_p3 == 32'd0) ? 1'b1 : 1'b0);

assign tmp_9_fu_579_p1 = write_req_contiguous_times_V_fu_555_p2;

assign tmp_s_fu_583_p2 = ((tmp_9_fu_579_p1 == throttle_threshold_3_fu_494_p3) ? 1'b1 : 1'b0);

assign valid_read_resp_3_phi_fu_341_p10 = ap_phi_precharge_reg_pp0_iter2_valid_read_resp_3_reg_336;

assign valid_write_req_data_3_phi_fu_307_p10 = ap_phi_precharge_reg_pp0_iter2_valid_write_req_data_3_reg_302;

assign write_req_contiguous_times_V_fu_555_p2 = (p_0_1_fu_478_p3 + 25'd1);

assign write_req_stall_1_fu_513_p2 = (write_req_stall_fu_186 & not_empty_n_fu_508_p2);

assign write_req_stall_times_1_fu_519_p3 = ((empty_n_reg_871[0:0] === 1'b1) ? 32'd0 : write_req_stall_times_fu_182);

assign write_req_stall_times_2_fu_612_p2 = (write_req_stall_times_1_fu_519_p3 + 32'd1);

endmodule //host_dram_throttle_unit
