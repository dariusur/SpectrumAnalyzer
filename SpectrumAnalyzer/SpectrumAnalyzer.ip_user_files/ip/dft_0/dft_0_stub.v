// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Sat Jan  6 16:03:21 2024
// Host        : DESKTOP-7B2FBLM running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/Darius/Desktop/coding_stuff/projects_for_resume/SpectrumAnalyzer/Vivado/DFT_TEST_2/DFT_TEST_2.gen/sources_1/ip/dft_0/dft_0_stub.v
// Design      : dft_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dft_v4_2_3,Vivado 2022.2" *)
module dft_0(CLK, SCLR, XN_RE, XN_IM, FD_IN, FWD_INV, SIZE, RFFD, 
  XK_RE, XK_IM, BLK_EXP, FD_OUT, DATA_VALID)
/* synthesis syn_black_box black_box_pad_pin="CLK,SCLR,XN_RE[11:0],XN_IM[11:0],FD_IN,FWD_INV,SIZE[5:0],RFFD,XK_RE[11:0],XK_IM[11:0],BLK_EXP[3:0],FD_OUT,DATA_VALID" */;
  input CLK;
  input SCLR;
  input [11:0]XN_RE;
  input [11:0]XN_IM;
  input FD_IN;
  input FWD_INV;
  input [5:0]SIZE;
  output RFFD;
  output [11:0]XK_RE;
  output [11:0]XK_IM;
  output [3:0]BLK_EXP;
  output FD_OUT;
  output DATA_VALID;
endmodule
