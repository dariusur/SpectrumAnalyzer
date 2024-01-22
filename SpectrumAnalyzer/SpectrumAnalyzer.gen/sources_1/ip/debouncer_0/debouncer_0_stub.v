// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Fri Jan 12 10:39:07 2024
// Host        : DESKTOP-7B2FBLM running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top debouncer_0 -prefix
//               debouncer_0_ debouncer_0_stub.v
// Design      : debouncer_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "debouncer,Vivado 2022.2" *)
module debouncer_0(clk, btn_in, btn_out)
/* synthesis syn_black_box black_box_pad_pin="clk,btn_in,btn_out" */;
  input clk;
  input btn_in;
  output btn_out;
endmodule
