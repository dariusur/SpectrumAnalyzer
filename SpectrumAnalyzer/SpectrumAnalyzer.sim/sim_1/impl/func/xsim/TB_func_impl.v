// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Sun Aug  6 14:04:17 2023
// Host        : DESKTOP-7B2FBLM running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               C:/Users/Darius/Desktop/Vivado/ROM_FFT_UART/ROM_FFT_UART.sim/sim_1/impl/func/xsim/TB_func_impl.v
// Design      : MEMORY
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* ECO_CHECKSUM = "a253b9a5" *) 
(* NotValidForBitStream *)
module MEMORY
   (clk,
    addr,
    dout);
  input clk;
  input [1:0]addr;
  output [3:0]dout;

  wire [1:0]addr;
  wire [1:0]addr_IBUF;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire [3:0]dout;
  wire \dout[0]_i_1_n_0 ;
  wire \dout[1]_i_1_n_0 ;
  wire \dout[2]_i_1_n_0 ;
  wire \dout[3]_i_1_n_0 ;
  wire [3:0]dout_OBUF;

  IBUF #(
    .CCIO_EN("TRUE")) 
    \addr_IBUF[0]_inst 
       (.I(addr[0]),
        .O(addr_IBUF[0]));
  IBUF #(
    .CCIO_EN("TRUE")) 
    \addr_IBUF[1]_inst 
       (.I(addr[1]),
        .O(addr_IBUF[1]));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF #(
    .CCIO_EN("TRUE")) 
    clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \dout[0]_i_1 
       (.I0(addr_IBUF[1]),
        .I1(addr_IBUF[0]),
        .O(\dout[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \dout[1]_i_1 
       (.I0(addr_IBUF[0]),
        .I1(addr_IBUF[1]),
        .O(\dout[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \dout[2]_i_1 
       (.I0(addr_IBUF[1]),
        .I1(addr_IBUF[0]),
        .O(\dout[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \dout[3]_i_1 
       (.I0(addr_IBUF[1]),
        .I1(addr_IBUF[0]),
        .O(\dout[3]_i_1_n_0 ));
  OBUF \dout_OBUF[0]_inst 
       (.I(dout_OBUF[0]),
        .O(dout[0]));
  OBUF \dout_OBUF[1]_inst 
       (.I(dout_OBUF[1]),
        .O(dout[1]));
  OBUF \dout_OBUF[2]_inst 
       (.I(dout_OBUF[2]),
        .O(dout[2]));
  OBUF \dout_OBUF[3]_inst 
       (.I(dout_OBUF[3]),
        .O(dout[3]));
  FDRE #(
    .INIT(1'b0)) 
    \dout_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\dout[0]_i_1_n_0 ),
        .Q(dout_OBUF[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \dout_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\dout[1]_i_1_n_0 ),
        .Q(dout_OBUF[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \dout_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\dout[2]_i_1_n_0 ),
        .Q(dout_OBUF[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \dout_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\dout[3]_i_1_n_0 ),
        .Q(dout_OBUF[3]),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
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
    reg GRESTORE_int;

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
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

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

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
