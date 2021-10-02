// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Tue Nov 17 00:51:21 2020
// Host        : DESKTOP-1A7GA3L running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {C:/Users/chris/Desktop/School/Fall 2020 Semester/CSCE
//               3730/Project/Alarm_Clock/Alarm_Clock.srcs/sources_1/ip/dist_mem_gen_0/dist_mem_gen_0_stub.v}
// Design      : dist_mem_gen_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2019.2" *)
module dist_mem_gen_0(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[9:0],spo[9:0]" */;
  input [9:0]a;
  output [9:0]spo;
endmodule
